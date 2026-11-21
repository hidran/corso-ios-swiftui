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

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Pokédex")
        }
        .task { await load() }
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading:
            ProgressView("Prepariamo la lista")
        case .loaded(let page):
            List(page.results) { entry in
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
        case .failed:
            ContentUnavailableView {
                Label("Lista non disponibile", systemImage: "wifi.slash")
            } description: {
                Text("Controllate la connessione e riprovate.")
            } actions: {
                Button("Riprova") {
                    Task { await load() }
                }
            }
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
