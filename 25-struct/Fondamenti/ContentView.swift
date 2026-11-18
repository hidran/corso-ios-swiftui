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

struct Pizza {
    let name: String
    var price: Double

    func label() -> String {
        return "\(name) costa \(price) euro"
    }

    mutating func discount(_ amount: Double) {
        price -= amount
    }
}

#Playground {
    let margherita = Pizza(name: "Margherita", price: 6.5)
    let cost = margherita.price
    let text = margherita.label()

    var diavola = Pizza(name: "Diavola", price: 9)
    let before = diavola.price
    diavola.discount(1.5)
    let after = diavola.price
}
