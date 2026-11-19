//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Pokemon: Identifiable {
    let id: Int
    let name: String

    var spriteURL: URL? {
        URL(string: spriteFolder + "\(id).png")
    }
}

let spriteFolder = "https://raw.githubusercontent.com/"
    + "PokeAPI/sprites/master/sprites/pokemon/"

let starters = [
    Pokemon(id: 1, name: "Bulbasaur"),
    Pokemon(id: 4, name: "Charmander"),
    Pokemon(id: 7, name: "Squirtle"),
    Pokemon(id: 25, name: "Pikachu"),
    Pokemon(id: 133, name: "Eevee"),
    Pokemon(id: 9999, name: "MissingNo")
]

let imageCache = URLCache(memoryCapacity: 20_000_000,
                          diskCapacity: 100_000_000)

func makeImageSession() -> URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = imageCache
    return URLSession(configuration: configuration)
}

let imageSession = makeImageSession()

struct PokemonList: View {
    @State private var cachedKB = 0

    var body: some View {
        List(starters) { pokemon in
            HStack {
                AsyncImage(url: pokemon.spriteURL) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    } else if phase.error != nil {
                        Image(systemName: "questionmark.circle")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 64, height: 64)
                Text(pokemon.name)
            }
        }
        .navigationTitle("Pokémon")
        .toolbar {
            Button("Cache: \(cachedKB) KB") {
                cachedKB = imageCache.currentMemoryUsage / 1024
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            if #available(iOS 27.0, *) {
                PokemonList()
                    .asyncImageURLSession(imageSession)
            } else {
                PokemonList()
            }
        }
    }
}

#Preview {
    ContentView()
}
