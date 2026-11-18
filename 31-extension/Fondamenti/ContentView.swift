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

extension Double {
    var euro: String {
        return "\(self) euro"
    }
}

protocol Priced {
    var name: String { get }
    var price: Double { get }
    func label() -> String
}

extension Priced {
    func label() -> String {
        return "\(name): \(price.euro)"
    }
}

struct Pizza: Priced {
    let name: String
    let price: Double
}

extension Pizza: CustomStringConvertible {
    var description: String {
        return "Pizza \(name)"
    }
}

struct Drink: Priced {
    let name: String
    let price: Double

    func label() -> String {
        return "Bibita \(name): \(price.euro)"
    }
}

#Playground {
    let cover = 2.5
    let coverText = cover.euro
    let total = (6.5 + cover).euro

    let margherita = Pizza(name: "Margherita", price: 6.5)
    let pizzaText = margherita.label()

    let water = Drink(name: "Acqua", price: 2.5)
    let drinkText = water.label()

    let order = "Ordine: \(margherita)"
}
