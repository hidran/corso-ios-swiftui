//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Pizza: Identifiable {
    let id = UUID()
    let name: String
}

struct ContentView: View {
    @State private var pizzas = [
        Pizza(name: "Margherita"),
        Pizza(name: "Diavola"),
        Pizza(name: "Capricciosa"),
        Pizza(name: "Marinara")
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(pizzas) { pizza in
                    Text(pizza.name)
                        .swipeActions(edge: .leading) {
                            Button("Preferita") { }
                                .tint(.yellow)
                        }
                }
                .onDelete { offsets in
                    pizzas.remove(atOffsets: offsets)
                }
                .onMove { from, to in
                    pizzas.move(fromOffsets: from, toOffset: to)
                }
            }
            .navigationTitle("Pizze")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ContentView()
}
