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
    private var items: [String] = []
    private(set) var total = 0.0
    static var opened = 0

    init() {
        Order.opened += 1
    }

    mutating func add(_ name: String, price: Double) {
        items.append(name)
        total += price
    }

    func summary() -> String {
        return "\(items.count) piatti, \(total) euro"
    }

    static func cover(for people: Int) -> Double {
        return Double(people) * 1.5
    }
}

#Playground {
    var order = Order()
    order.add("Margherita", price: 6.5)
    order.add("Diavola", price: 8.5)
    let before = order.summary()

    order.add("Bibita", price: 2.5)
    let after = order.summary()
    let paid = order.total

    var second = Order()
    second.add("Marinara", price: 5)
    let opened = Order.opened
    let cover = Order.cover(for: 4)
}
