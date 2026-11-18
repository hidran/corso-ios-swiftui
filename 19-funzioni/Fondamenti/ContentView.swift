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

func price(pizzas: Int) -> Double {
    return Double(pizzas) * 6.5
}

func total(for pizzas: Int, at price: Double = 6.5) -> Double {
    return Double(pizzas) * price
}

func greet(_ name: String) -> String {
    "Ciao, \(name)!"
}

#Playground {
    let order = price(pizzas: 3)
    let party = price(pizzas: 10)

    let dinner = total(for: 2, at: 8)

    let welcome = greet("Anna")

    let lunch = total(for: 4)
}
