//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    let pizzas = ["Margherita", "Diavola", "Capricciosa",
                  "Marinara", "Quattro formaggi", "Bufalina"]
    @State private var query = ""

    var results: [String] {
        if query.isEmpty {
            return pizzas
        }
        return pizzas.filter { pizza in
            pizza.localizedStandardContains(query)
        }
    }

    var body: some View {
        NavigationStack {
            List(results, id: \.self) { pizza in
                Text(pizza)
            }
            .navigationTitle("Pizze")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Aggiungi", systemImage: "plus") { }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Preferite") { }
                }
                if #available(iOS 27, *) {
                    ToolbarOverflowMenu {
                        Button("Condividi") { }
                        Button("Stampa") { }
                    }
                }
            }
            .searchable(text: $query, prompt: "Cerca una pizza")
        }
    }
}

#Preview {
    ContentView()
}
