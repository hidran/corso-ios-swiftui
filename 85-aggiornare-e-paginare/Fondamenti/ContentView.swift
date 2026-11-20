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
    var id: String { name }
}

enum PageError: Error {
    case badResponse
}

func fetchPage(_ address: String) async throws -> PokemonPage {
    guard let url = URL(string: address) else {
        throw PageError.badResponse
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw PageError.badResponse
    }
    return try JSONDecoder().decode(PokemonPage.self, from: data)
}

struct ContentView: View {
    let firstPage = "https://pokeapi.co/api/v2/pokemon?limit=20"
    @State private var pokemon: [PokemonEntry] = []
    @State private var nextPage: String?
    @State private var loading = false
    @State private var message = ""

    var body: some View {
        NavigationStack {
            List(pokemon) { entry in
                Text(entry.name.capitalized)
                    .onAppear {
                        if entry.id == pokemon.last?.id {
                            Task { await loadNext() }
                        }
                    }
            }
            .overlay(alignment: .bottom) {
                if !message.isEmpty {
                    Text(message).padding().background(.regularMaterial)
                }
            }
            .refreshable { await refresh() }
            .navigationTitle("Pokémon")
        }
        .task { await refresh() }
    }

    func refresh() async {
        guard !loading else { return }
        loading = true
        defer { loading = false }
        do {
            let page = try await fetchPage(firstPage)
            pokemon = page.results
            nextPage = page.next
            message = ""
        } catch {
            message = "Aggiornamento non riuscito"
        }
    }

    func loadNext() async {
        guard !loading, let address = nextPage else { return }
        loading = true
        defer { loading = false }
        do {
            let page = try await fetchPage(address)
            pokemon.append(contentsOf: page.results)
            nextPage = page.next
            message = ""
        } catch {
            message = "Caricamento non riuscito"
        }
    }
}

#Preview {
    ContentView()
}
