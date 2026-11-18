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
    let pizzas = ["Margherita", "Diavola", "Marinara"]
    let loud = pizzas.map { $0.uppercased() }

    let prices = [6.5, 8, 5, 9.5]
    let cheap = prices.filter { $0 < 7 }
    let howMany = cheap.count
    let total = prices.reduce(0) { $0 + $1 }

    let byPrice = prices.sorted { $0 > $1 }
    let top = byPrice[0]
    let original = prices[0]

    let budget = prices.filter { $0 < 9 }.reduce(0) { $0 + $1 }
}
