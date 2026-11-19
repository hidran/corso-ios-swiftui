//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var history: [String] = []
    @State private var returns = 0

    var body: some View {
        NavigationStack {
            List {
                Section("Adesso") {
                    Text("Fase: \(name(of: scenePhase))")
                    Text("Ritorni: \(returns)")
                }
                Section("Cronologia") {
                    ForEach(history.indices, id: \.self) { i in
                        Text(history[i])
                    }
                }
            }
            .navigationTitle("Ciclo di vita")
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            history.append(name(of: newPhase))
            if oldPhase == .background {
                returns += 1
            }
        }
    }

    func name(of phase: ScenePhase) -> String {
        switch phase {
        case .active:
            return "attiva"
        case .inactive:
            return "inattiva"
        case .background:
            return "in background"
        @unknown default:
            return "sconosciuta"
        }
    }
}

#Preview {
    ContentView()
}
