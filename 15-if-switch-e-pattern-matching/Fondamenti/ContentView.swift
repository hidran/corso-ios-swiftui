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
    let total = 64.0
    let delivery = if total >= 50 {
        0.0
    } else if total >= 30 {
        2.0
    } else {
        5.0
    }
    print("Consegna:", delivery)

    let guests = 7
    let table: String
    switch guests {
    case 0:
        table = "nessuno"
    case 1...4:
        table = "piccolo"
    case 5..<10:
        table = "grande"
    default:
        table = "la sala intera"
    }
    print("Tavolo:", table)

    let order = (pizzas: 12, takeaway: true)
    let note = switch order {
    case (0, _):
        "Ordine vuoto"
    case (let n, _) where n > 10:
        "Ordine grande: \(n) pizze"
    case (_, true):
        "Da asporto"
    default:
        "Al tavolo"
    }
    print("Nota:", note)
}
