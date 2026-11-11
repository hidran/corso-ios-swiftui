//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Pizza: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
}

struct ContentView: View {
    let pizzas = [
        Pizza(name: "Margherita", price: 6.5),
        Pizza(name: "Diavola", price: 7.5),
        Pizza(name: "Capricciosa", price: 8)
    ]

    var body: some View {
        NavigationStack {
            List(pizzas) { pizza in
                NavigationLink(pizza.name, value: pizza)
            }
            .navigationTitle("Pizze")
            .navigationDestination(for: Pizza.self) { pizza in
                PizzaDetail(pizza: pizza)
            }
        }
    }
}

struct PizzaDetail: View {
    let pizza: Pizza
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text(pizza.price, format: .currency(code: "EUR"))
                .font(.largeTitle)
            Button("Torna all'elenco") {
                dismiss()
            }
        }
        .navigationTitle(pizza.name)
    }
}

#Preview {
    ContentView()
}
