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
    var toppings: Set = ["Mozzarella", "Basilico", "Pomodoro"]
    toppings.insert("Basilico")
    toppings.insert("Olive")
    print("Ingredienti:", toppings.count)

    print("C'è il basilico?", toppings.contains("Basilico"))
    let allergens: Set = ["Mozzarella", "Noci"]
    let shared = toppings.intersection(allergens)
    print("In comune:", shared.count)

    var prices = ["Margherita": 6.5, "Diavola": 7.5]
    prices["Bufala"] = 9.0
    prices["Diavola"] = 8.0
    prices.removeValue(forKey: "Margherita")
    print("Pizze nel menu:", prices.count)

    let diavola = prices["Diavola", default: 0]
    let calzone = prices["Calzone", default: 0]
    print("Diavola:", diavola, "Calzone:", calzone)

    var orders: [String: Int] = [:]
    orders["Anna", default: 0] += 2
    orders["Luca", default: 0] += 1
    orders["Anna", default: 0] += 1
    print("Ordini di Anna:", orders["Anna", default: 0])
}
