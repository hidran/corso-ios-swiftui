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

class Dish {
    let name: String
    var price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    func label() -> String {
        return "\(name): \(price) euro"
    }
}

final class Pizza: Dish {
    let slices: Int

    init(name: String, price: Double, slices: Int) {
        self.slices = slices
        super.init(name: name, price: price)
    }

    override func label() -> String {
        return "\(super.label()), \(slices) fette"
    }
}

#Playground {
    let water = Dish(name: "Acqua", price: 2.5)
    let line = water.label()

    let diavola = Pizza(name: "Diavola", price: 8.5, slices: 6)
    let pieces = diavola.slices
    let pizzaLine = diavola.label()

    let menu: [Dish] = [water, diavola]
    let fromMenu = menu[1].label()
    let howMany = menu.count
}
