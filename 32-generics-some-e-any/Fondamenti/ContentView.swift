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

func largest<T: Comparable>(_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

struct Queue<Item> {
    var items: [Item] = []

    mutating func add(_ item: Item) {
        items.append(item)
    }
}

protocol Priced {
    var price: Double { get }
}

struct Pizza: Priced {
    let price: Double
}

struct Drink: Priced {
    let price: Double
}

func withCover(_ item: some Priced) -> Double {
    return item.price + 1.5
}

#Playground {
    let bigger = largest(3, 8)
    let later = largest("Diavola", "Margherita")
    let higher = largest(6.5, 9.5)

    var orders = Queue<String>()
    orders.add("Diavola")
    orders.add("Capricciosa")
    let waiting = orders.items.count
    let firstOrder = orders.items[0]

    let margherita = Pizza(price: 6.5)
    let water = Drink(price: 2.5)
    let pizzaCost = withCover(margherita)
    let drinkCost = withCover(water)

    let order: [any Priced] = [margherita, water]
    let total = order.reduce(0) { $0 + $1.price }
    let items = order.count
}
