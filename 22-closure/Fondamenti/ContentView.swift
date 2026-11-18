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

func pay(_ amount: Double, rule: (Double) -> Double) -> Double {
    return rule(amount)
}

#Playground {
    let withCover = { (amount: Double) -> Double in
        return amount + 2
    }
    let table = withCover(40)

    let low = pay(40, rule: { (price: Double) -> Double in
        return price - 5
    })
    let covered = pay(40, rule: withCover)

    let late = pay(30) { price in price - 5 }
    let half = pay(40) { $0 / 2 }
}
