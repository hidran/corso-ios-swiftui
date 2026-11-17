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
    let order = ("Diavola", 2)
    print("Pizza:", order.0, "Quante:", order.1)

    let diavola = (name: "Diavola", price: 7.5)
    print(diavola.name, "costa", diavola.price)

    let (name, price) = diavola
    let (_, quantity) = order
    print(name, "x", quantity, "=", price * Double(quantity))

    let split = 7.quotientAndRemainder(dividingBy: 2)
    print("A testa:", split.quotient)
    print("Avanzano:", split.remainder)

    let menu = ["Margherita": 6.5, "Bufala": 9.0]
    var total = 0.0
    for (_, cost) in menu {
        total += cost
    }
    print("Tutto il menu:", total)
}
