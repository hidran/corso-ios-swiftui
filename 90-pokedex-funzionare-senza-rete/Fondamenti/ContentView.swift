//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct PokemonPage: Decodable {
    let next: String?
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable, Identifiable {
    let name: String
    let url: URL

    var id: String { name }
}

enum PokemonError: Error {
    case badResponse
}

func fetchPokemonData(from url: URL) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw PokemonError.badResponse
    }
    return data
}

func fetchPage(from url: URL) async throws -> PokemonPage {
    let data = try await fetchPokemonData(from: url)
    return try JSONDecoder().decode(PokemonPage.self, from: data)
}

struct PokemonDetail: Decodable {
    let name: String
    let sprites: Sprites

    struct Sprites: Decodable {
        let front: URL?

        enum CodingKeys: String, CodingKey {
            case front = "front_default"
        }
    }
}

func fetchDetail(from url: URL) async throws -> PokemonDetail {
    let data = try await fetchPokemonData(from: url)
    return try JSONDecoder().decode(PokemonDetail.self, from: data)
}

enum PokedexDisk {
    static func location(_ key: String) throws -> URL {
        let directory = URL.cachesDirectory
            .appendingPathComponent("Pokedex", isDirectory: true)
        try FileManager.default.createDirectory(
            at: directory, withIntermediateDirectories: true
        )
        return directory.appendingPathComponent(key)
    }

    static func save(_ data: Data, as key: String) throws {
        try data.write(to: location(key), options: .atomic)
    }

    static func read(_ key: String) throws -> Data {
        try Data(contentsOf: location(key))
    }
}

enum OfflineDemo: Error {
    case noConnection
}

func networkData(from url: URL, offline: Bool) async throws -> Data {
    if offline { throw OfflineDemo.noConnection }
    return try await fetchPokemonData(from: url)
}

func localData(
    from url: URL, key: String, offline: Bool
) async throws -> Data {
    do {
        let data = try await networkData(from: url, offline: offline)
        try Task.checkCancellation()
        try? PokedexDisk.save(data, as: key)
        return data
    } catch {
        try Task.checkCancellation()
        return try PokedexDisk.read(key)
    }
}

enum PokedexState {
    case loading
    case loaded(PokemonPage)
    case failed
}

struct ContentView: View {
    private let endpoint = URL(
        string: "https://pokeapi.co/api/v2/pokemon?limit=20"
    )!
    @State private var state = PokedexState.loading
    @State private var offlineDemo = false
    @State private var usingCopy = false
    @State private var paging = false
    @State private var pageFailed = false
    @State private var query = ""
    @State private var found: PokemonEntry?
    @State private var searchMessage = ""

    private var searchTerm: String {
        query.trimmingCharacters(in: .whitespaces).lowercased()
    }

    var body: some View {
        NavigationStack {
            Group {
                if searchTerm.isEmpty {
                    content
                } else {
                    searchResults
                }
            }
            .navigationTitle("Pokédex")
            .toolbar {
                Button(offlineDemo ? "Torna in rete" : "Simula offline") {
                    offlineDemo.toggle()
                }
            }
            .safeAreaInset(edge: .bottom) {
                if query.isEmpty, case .loaded = state {
                    Text(usingCopy ? "Copia salvata" : "Dati dalla rete")
                        .padding(6)
                }
            }
            .searchable(text: $query,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Cerca nel Pokédex")
        }
        .task(id: offlineDemo) { await load() }
        .task(id: searchTerm) { [searchTerm] in
            await lookup(searchTerm)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading:
            ProgressView("Prepariamo la lista")
        case .loaded(let page):
            List {
                ForEach(page.results) { entry in
                    row(for: entry)
                }
                if page.next != nil {
                    if pageFailed {
                        Button("Riprova la pagina") {
                            Task { await append(page) }
                        }
                    } else {
                        ProgressView()
                            .task(id: page.next) { await append(page) }
                    }
                }
            }
        case .failed:
            ContentUnavailableView {
                Label("Lista non disponibile", systemImage: "wifi.slash")
            } actions: {
                Button("Riprova") {
                    Task { await load() }
                }
            }
        }
    }

    private var searchResults: some View {
        List {
            if let found {
                row(for: found)
            } else if !searchMessage.isEmpty {
                Text(searchMessage)
            } else {
                ProgressView()
            }
        }
    }

    @ViewBuilder
    private func row(for entry: PokemonEntry) -> some View {
        NavigationLink {
            DetailView(entry: entry, offlineDemo: offlineDemo)
        } label: {
            Text(entry.name.capitalized)
        }
    }

    private func load() async {
        state = .loading
        do {
            let data = try await networkData(
                from: endpoint, offline: offlineDemo
            )
            let page = try JSONDecoder().decode(PokemonPage.self, from: data)
            try Task.checkCancellation()
            try? PokedexDisk.save(data, as: "page.json")
            usingCopy = false
            state = .loaded(page)
        } catch {
            guard !Task.isCancelled else { return }
            let saved = try? PokedexDisk.read("page.json")
            if let saved,
               let page = try? JSONDecoder().decode(
                   PokemonPage.self, from: saved
               ) {
                usingCopy = true
                state = .loaded(PokemonPage(next: nil, results: page.results))
            } else {
                state = .failed
            }
        }
    }

    private func append(_ page: PokemonPage) async {
        guard !paging, let link = page.next, let url = URL(string: link)
        else { return }
        guard case .loaded(let current) = state, current.next == link
        else { return }
        paging = true
        defer { paging = false }
        do {
            let data = try await networkData(from: url, offline: offlineDemo)
            let next = try JSONDecoder().decode(PokemonPage.self, from: data)
            try Task.checkCancellation()
            let all = current.results + next.results
            state = .loaded(PokemonPage(next: next.next, results: all))
            pageFailed = false
        } catch {
            guard !Task.isCancelled else { return }
            pageFailed = true
        }
    }

    private func lookup(_ term: String) async {
        found = nil
        searchMessage = ""
        guard !term.isEmpty else { return }
        let base = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        let url = base.appendingPathComponent(term)
        do {
            try await Task.sleep(for: .milliseconds(500))
            let data = try await networkData(from: url, offline: offlineDemo)
            let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
            try Task.checkCancellation()
            found = PokemonEntry(name: detail.name, url: url)
        } catch {
            guard !Task.isCancelled else { return }
            searchMessage = "Nessun risultato disponibile"
        }
    }
}

struct DetailView: View {
    let entry: PokemonEntry
    let offlineDemo: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var detail: PokemonDetail?
    @State private var sprite: UIImage?
    @State private var failed = false

    var body: some View {
        VStack {
            if let detail {
                if let sprite {
                    Image(uiImage: sprite).resizable().scaledToFit()
                        .frame(width: 140, height: 140)
                } else {
                    Image(systemName: "photo")
                }
                Text("Nome: \(detail.name.capitalized)")
            } else if failed {
                Text("Scheda non disponibile")
            } else {
                ProgressView()
            }
        }
        .navigationTitle(entry.name.capitalized)
        .toolbar {
            Button("Elenco") { dismiss() }
        }
        .task(id: entry.id) { await load() }
    }

    private func load() async {
        do {
            let data = try await localData(
                from: entry.url, key: entry.id + ".json", offline: offlineDemo
            )
            try Task.checkCancellation()
            let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
            if let url = decoded.sprites.front,
               let bytes = try? await localData(
                from: url, key: entry.id + ".png", offline: offlineDemo
               ) {
                sprite = UIImage(data: bytes)
            }
            try Task.checkCancellation()
            detail = decoded
        } catch {
            guard !Task.isCancelled else { return }
            failed = true
        }
    }
}

#Preview {
    ContentView()
}
