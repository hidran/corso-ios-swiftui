//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct PokemonPage: Decodable {
    let count: Int
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable, Identifiable {
    let name: String
    let url: String

    var id: String { name }
}

enum LoadError: Error {
    case badStatus(Int)
}

func fetchPokemon() async throws -> PokemonPage {
    let address = "https://pokeapi.co/api/v2/pokemon?limit=10"
    let url = URL(string: address)!
    let session = URLSession.shared
    let (data, response) = try await session.data(from: url)
    let status = (response as? HTTPURLResponse)?.statusCode
    guard status == 200 else {
        throw LoadError.badStatus(status ?? 0)
    }
    return try JSONDecoder().decode(PokemonPage.self, from: data)
}

enum LoadState {
    case loading
    case loaded([PokemonEntry])
    case failed(String)
}

struct ContentView: View {
    @State private var state = LoadState.loading

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Pokémon")
        }
        .task {
            await load()
        }
    }

    @ViewBuilder
    var content: some View {
        switch state {
        case .loading:
            ProgressView("Caricamento...")
        case .loaded(let pokemon):
            List(pokemon) { entry in
                Text(entry.name.capitalized)
            }
        case .failed(let message):
            ContentUnavailableView {
                Label("Niente Pokémon", systemImage: "wifi.slash")
            } description: {
                Text(message)
            } actions: {
                Button("Riprova") {
                    Task { await load() }
                }
            }
        }
    }

    func load() async {
        state = .loading
        do {
            try await Task.sleep(for: .seconds(1))
            let page = try await fetchPokemon()
            state = .loaded(page.results)
        } catch LoadError.badStatus(let code) {
            state = .failed("Il server ha risposto \(code).")
        } catch {
            state = .failed("Controlla la connessione.")
        }
    }
}

#Preview {
    ContentView()
}
