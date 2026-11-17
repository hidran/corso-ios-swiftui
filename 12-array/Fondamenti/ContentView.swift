//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        Text("Swift essenziale")
    }
}

#Playground {
    var pizzas = ["Margherita", "Diavola", "Marinara"]
    let empty: [String] = []
    print("Nel menu:", pizzas.count, "Vuoto:", empty.isEmpty)

    print(pizzas[0], pizzas[2])
    print("C'è la Diavola?", pizzas.contains("Diavola"))

    pizzas.append("Capricciosa")
    pizzas[1] = "Bufala"
    pizzas.remove(at: 0)
    pizzas.insert("Quattro formaggi", at: 0)
    print("Adesso:", pizzas.count)

    for pizza in pizzas {
        print(pizza.uppercased())
    }

    let prices = [6.5, 7.0, 8.5]
    var total = 0.0
    for price in prices {
        total += price
    }
    print("Totale:", total)
}
