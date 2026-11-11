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
    @State private var path = NavigationPath()
    let pizzas = [
        Pizza(name: "Margherita", price: 6.5),
        Pizza(name: "Diavola", price: 7.5),
        Pizza(name: "Capricciosa", price: 8)
    ]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(pizzas) { pizza in
                    NavigationLink(pizza.name, value: pizza)
                }
                Button("Pizza del giorno") {
                    path.append(pizzas[1])
                }
            }
            .navigationTitle("Pizze")
            .navigationDestination(for: Pizza.self) { pizza in
                PizzaDetail(pizza: pizza)
            }
            .navigationDestination(for: String.self) { name in
                VStack(spacing: 20) {
                    Text("Ingredienti di \(name)")
                    Button("Torna all'elenco") {
                        path = NavigationPath()
                    }
                }
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
            NavigationLink("Ingredienti", value: pizza.name)
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
