//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selected: String?
    let pizzas = ["Margherita", "Diavola", "Capricciosa"]

    var body: some View {
        NavigationSplitView {
            List(pizzas, id: \.self,
                 selection: $selected) { pizza in
                NavigationLink(pizza, value: pizza)
            }
            .navigationTitle("Menu")
        } detail: {
            if let selected {
                PizzaDetail(name: selected)
            } else {
                Text("Scegli una pizza")
            }
        }
    }
}

struct PizzaDetail: View {
    let name: String
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        VStack(spacing: 20) {
            Text(name)
                .font(.largeTitle)
            Text(sizeClass == .compact ? "Compatta" : "Regolare")
            ViewThatFits {
                HStack {
                    Button("Aggiungi al carrello") { }
                    Button("Aggiungi alle preferite") { }
                    Button("Condividi") { }
                }
                VStack {
                    Button("Aggiungi al carrello") { }
                    Button("Aggiungi alle preferite") { }
                    Button("Condividi") { }
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
