//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var team: [String] = []
    @State private var time = "Pronti"

    var body: some View {
        VStack(spacing: 16) {
            Text(time)
                .font(.title)
            ForEach(team, id: \.self) { name in
                Text(name)
            }
            Button("Carica la squadra") {
                Task {
                    await loadTeam()
                }
            }
            .buttonStyle(.bordered)
        }
    }

    func load(_ name: String) async -> String {
        try? await Task.sleep(for: .seconds(2))
        return name
    }

    func loadAll(_ names: [String]) async -> [String] {
        await withTaskGroup { group in
            for name in names {
                group.addTask { await load(name) }
            }
            var loaded: [String] = []
            for await pokemon in group {
                loaded.append(pokemon)
            }
            return loaded
        }
    }

    func loadTeam() async {
        team = []
        time = "Carico..."
        let start = ContinuousClock.now
        let names = ["Pikachu", "Eevee", "Mew", "Ditto", "Lapras"]
        team = await loadAll(names)
        let elapsed = ContinuousClock.now - start
        time = "Tempo: \(elapsed.components.seconds) secondi"
    }
}

#Preview {
    ContentView()
}
