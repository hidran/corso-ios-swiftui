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

func total(_ prices: Double...) -> Double {
    var sum = 0.0
    for price in prices {
        sum += price
    }
    return sum
}

func order(_ pizzas: String..., table: Int) -> String {
    return "Tavolo \(table): \(pizzas.count) pizze"
}

func addTip(to bill: inout Double, percent: Double) {
    bill += bill * percent / 100
}

#Playground {
    let three = total(6.5, 8, 7)
    let one = total(5)
    let empty = total()

    let ticket = order("Margherita", "Diavola", table: 4)

    var bill = 40.0
    addTip(to: &bill, percent: 10)
    print("Con la mancia:", bill)
}
