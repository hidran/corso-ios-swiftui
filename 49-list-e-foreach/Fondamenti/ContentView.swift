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
    let price: Double
}

struct ContentView: View {
    let pizzas = [
        Pizza(name: "Margherita", price: 6.5),
        Pizza(name: "Diavola", price: 7.5),
        Pizza(name: "Capricciosa", price: 8)
    ]

    var body: some View {
        List {
            Section("Pizze") {
                ForEach(pizzas) { pizza in
                    PizzaRow(pizza: pizza)
                }
            }
            Section("Bevande") {
                Text("Acqua")
                Text("Birra")
            }
        }
    }
}

struct PizzaRow: View {
    let pizza: Pizza

    var body: some View {
        HStack {
            Text(pizza.name)
            Spacer()
            Text(pizza.price, format: .currency(code: "EUR"))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
