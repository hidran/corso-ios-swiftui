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

func share(of total: Double, among people: Int) -> Double {
    guard people > 0 else {
        return 0
    }
    return total / Double(people)
}

func order(_ typed: String) -> String {
    guard let pizzas = Int(typed) else {
        return "\(typed) non è un numero"
    }
    guard pizzas > 0 else {
        return "Con \(pizzas) pizze non si ordina"
    }
    return "Ordine: \(pizzas) pizze"
}

#Playground {
    let each = share(of: 60, among: 4)
    let nobody = share(of: 60, among: 0)

    let first = order("3")
    let second = order("tre")
    let third = order("0")
}
