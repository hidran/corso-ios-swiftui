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
                Text(entry.name.capitalized)
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

#Preview {
    ContentView()
}
