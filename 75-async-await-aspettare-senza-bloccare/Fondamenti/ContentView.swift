//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var team: [String] = []
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            List(team, id: \.self) { name in
                Text(name)
            }
            .navigationTitle("La mia squadra")
            .overlay {
                if isLoading {
                    ProgressView("Carico la squadra...")
                }
            }
            .toolbar {
                Button("Carica") {
                    Task {
                        isLoading = true
                        team = await loadTeam()
                        isLoading = false
                    }
                }
            }
        }
    }

    func loadTeam() async -> [String] {
        try? await Task.sleep(for: .seconds(2))
        return ["Pikachu", "Bulbasaur", "Charmander"]
    }
}

#Preview {
    ContentView()
}
