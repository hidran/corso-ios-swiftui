//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Menu", systemImage: "fork.knife") {
                NavigationStack {
                    List {
                        Text("Margherita")
                        Text("Diavola")
                    }
                    .navigationTitle("Menu")
                }
            }
            Tab("Ordini", systemImage: "bag") {
                Text("I tuoi ordini")
                    .font(.largeTitle)
            }
            .badge(2)
            Tab("Cerca", systemImage: "magnifyingglass",
                role: .search) {
                Text("Cerca una pizza")
            }
        }
    }
}

#Preview {
    ContentView()
}
