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
    var total = 0
    for number in 1...5 {
        total += number
    }
    print("Da 1 a 5:", total)

    let pizzas = ["Margherita", "Diavola", "Marinara"]
    for i in 0..<pizzas.count {
        print(i, pizzas[i])
    }

    var cheer = ""
    for _ in 1...3 {
        cheer += "Pizza! "
    }
    print(cheer)

    var times = ""
    for minute in stride(from: 0, through: 60, by: 15) {
        times += "\(minute) "
    }
    print("Sfornate:", times)

    var budget = 20.0
    var bought = 0
    while budget >= 6.5 {
        budget -= 6.5
        bought += 1
    }
    print("Pizze:", bought, "Resto:", budget)

    var slices = 0
    repeat {
        slices += 4
    } while slices < 10
    print("Fette:", slices)
}
