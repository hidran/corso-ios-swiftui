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
    let address = "https://pokeapi.co/api/v2/pokemon?limit=5"
    let url = URL(string: address)!
    let session = URLSession.shared
    let (data, response) = try await session.data(from: url)
    let status = (response as? HTTPURLResponse)?.statusCode
    guard status == 200 else {
        throw LoadError.badStatus(status ?? 0)
    }
    return try JSONDecoder().decode(PokemonPage.self, from: data)
}

struct ContentView: View {
    @State private var pokemon: [PokemonEntry] = []
    @State private var message = "Caricamento..."

    var body: some View {
        NavigationStack {
            List(pokemon) { entry in
                Text(entry.name.capitalized)
            }
            .navigationTitle(message)
        }
        .task {
            await load()
        }
    }

    func load() async {
        do {
            let page = try await fetchPokemon()
            pokemon = page.results
            message = "\(page.count) Pokémon"
        } catch LoadError.badStatus(let code) {
            message = "Errore \(code)"
        } catch {
            message = "Qualcosa non va"
        }
    }
}

#Preview {
    ContentView()
}
