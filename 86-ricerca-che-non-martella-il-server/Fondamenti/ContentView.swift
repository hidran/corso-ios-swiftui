//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Pokemon: Decodable {
    let name: String
}

enum SearchError: Error {
    case notFound
    case badResponse
}

func findPokemon(_ name: String) async throws -> Pokemon {
    let endpoint = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    let url = endpoint.appendingPathComponent(name)
    let (data, response) = try await URLSession.shared.data(from: url)
    let status = (response as? HTTPURLResponse)?.statusCode
    if status == 404 { throw SearchError.notFound }
    guard status == 200 else { throw SearchError.badResponse }
    return try JSONDecoder().decode(Pokemon.self, from: data)
}

struct ContentView: View {
    @State private var query = ""
    @State private var message = "Scriviamo un nome"

    var body: some View {
        NavigationStack {
            List {
                Text(message)
            }
            .navigationTitle("Pokémon")
            .searchable(text: $query,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Cerca Pokémon")
        }
        .task(id: query) { [query] in
            await search(for: query)
        }
    }

    func search(for query: String) async {
        let name = query.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else {
            message = "Scriviamo un nome"
            return
        }
        do {
            try await Task.sleep(for: .milliseconds(500))
            let pokemon = try await findPokemon(name.lowercased())
            try Task.checkCancellation()
            message = pokemon.name.capitalized
        } catch {
            guard !Task.isCancelled else { return }
            if case SearchError.notFound = error {
                message = "Nessun Pokémon trovato"
            } else {
                message = "Ricerca non riuscita"
            }
        }
    }
}

#Preview {
    ContentView()
}
