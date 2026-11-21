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

private let detailImageSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = URLCache(
        memoryCapacity: 20_000_000, diskCapacity: 100_000_000
    )
    return URLSession(configuration: configuration)
}()

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
            .searchable(text: $query,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Cerca nel Pokédex")
        }
        .task { await load() }
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
            if #available(iOS 27, *) {
                DetailView(entry: entry)
                    .asyncImageURLSession(detailImageSession)
            } else {
                DetailView(entry: entry)
            }
        } label: {
            Text(entry.name.capitalized)
        }
    }

    private func load() async {
        state = .loading
        do {
            let page = try await fetchPage(from: endpoint)
            try Task.checkCancellation()
            state = .loaded(page)
        } catch {
            guard !Task.isCancelled else { return }
            state = .failed
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
            let next = try await fetchPage(from: url)
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
            let detail = try await fetchDetail(from: url)
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
    @State private var detail: PokemonDetail?
    @State private var failed = false

    var body: some View {
        VStack {
            if let detail {
                AsyncImage(url: detail.sprites.front) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 140, height: 140)
                Text("Nome: \(detail.name.capitalized)")
            } else if failed {
                Text("Scheda non disponibile")
            } else {
                ProgressView()
            }
        }
        .navigationTitle(entry.name.capitalized)
        .task(id: entry.id) { await load() }
    }

    private func load() async {
        do {
            let result = try await fetchDetail(from: entry.url)
            try Task.checkCancellation()
            detail = result
        } catch {
            guard !Task.isCancelled else { return }
            failed = true
        }
    }
}

#Preview {
    ContentView()
}
