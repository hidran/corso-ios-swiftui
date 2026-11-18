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

protocol Priced {
    var price: Double { get }
    func label() -> String
}

struct Pizza: Priced, Hashable, Comparable, Identifiable {
    let name: String
    let price: Double

    func label() -> String {
        return "\(name), \(price) euro"
    }

    static func < (lhs: Pizza, rhs: Pizza) -> Bool {
        return lhs.price < rhs.price
    }

    var id: String {
        return name
    }
}

#Playground {
    let margherita = Pizza(name: "Margherita", price: 6.5)
    let text = margherita.label()

    let copy = Pizza(name: "Margherita", price: 6.5)
    let equal = margherita == copy
    let menu: Set = [margherita, copy]
    let unique = menu.count

    let diavola = Pizza(name: "Diavola", price: 9)
    let cheaper = margherita < diavola
    let names = [diavola, margherita].sorted().map { $0.name }

    let key = diavola.id
}
