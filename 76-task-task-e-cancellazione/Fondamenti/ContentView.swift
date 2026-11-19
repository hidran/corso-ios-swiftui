//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var status = "Pronto"
    @State private var job: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 24) {
            Text(status)
                .font(.title)
            Button("Avvia") {
                job = Task {
                    await hatch()
                }
            }
            Button("Ferma") {
                job?.cancel()
            }
        }
        .buttonStyle(.bordered)
        .task {
            await hatch()
        }
    }

    func hatch() async {
        do {
            for n in (1...10).reversed() {
                status = "Si schiude tra \(n)"
                try await Task.sleep(for: .seconds(1))
            }
            status = "Ecco Togepi!"
        } catch {
            status = "Annullato"
        }
    }
}

#Preview {
    ContentView()
}
