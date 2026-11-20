//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

actor PokemonBox {
    private var caught: [String] = []

    func add(_ name: String) {
        caught.append(name)
    }

    var count: Int {
        caught.count
    }
}

struct ContentView: View {
    @State private var message = "Box vuoto"
    private let box = PokemonBox()

    var body: some View {
        VStack(spacing: 24) {
            Text(message)
                .font(.title)
            Button("Cattura 100 Pokémon") {
                Task {
                    await catchAll()
                }
            }
            .buttonStyle(.bordered)
        }
    }

    func catchAll() async {
        await withTaskGroup { group in
            for n in 1...100 {
                group.addTask {
                    await box.add("Pokémon \(n)")
                }
            }
        }
        let total = await box.count
        message = "Nel box: \(total)"
    }
}

#Preview {
    ContentView()
}
