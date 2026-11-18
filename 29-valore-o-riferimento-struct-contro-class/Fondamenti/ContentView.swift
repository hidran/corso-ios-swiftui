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

struct Order {
    var pizzas: Int
}

class Table {
    var guests: Int

    init(guests: Int) {
        self.guests = guests
    }
}

class Oven {
    var pizza = "Margherita"
    var onReady: () -> String = { "Forno spento" }

    func start() {
        onReady = { [weak self] in
            guard let self else { return "Forno spento" }
            return "Pronta la \(self.pizza)"
        }
    }
}

#Playground {
    let first = Order(pizzas: 2)
    var copy = first
    copy.pizzas = 5
    let original = first.pizzas
    let changed = copy.pizzas

    let table = Table(guests: 4)
    let sameTable = table
    sameTable.guests = 6
    let fromTable = table.guests
    let fromSame = sameTable.guests

    let identical = table === sameTable
    let twin = Table(guests: 6)
    let different = table === twin
    let sameGuests = table.guests == twin.guests

    let oven = Oven()
    oven.start()
    let message = oven.onReady()
    oven.pizza = "Diavola"
    let later = oven.onReady()
}
