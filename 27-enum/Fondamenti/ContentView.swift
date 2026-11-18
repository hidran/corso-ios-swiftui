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

enum Size: String, CaseIterable {
    case small = "Piccola", medium = "Media", large = "Grande"
}

func price(of size: Size) -> Double {
    switch size {
    case .small:
        return 5.5
    case .medium:
        return 7
    case .large:
        return 9.5
    }
}

enum Order {
    case takeaway
    case table(Int)
    case delivery(address: String)
}

func describe(_ order: Order) -> String {
    switch order {
    case .takeaway:
        return "Da asporto"
    case .table(let number):
        return "Al tavolo \(number)"
    case .delivery(let address):
        return "Consegna in \(address)"
    }
}

#Playground {
    let big = price(of: .large)
    let little = price(of: .small)

    let unknown = Size(rawValue: "Enorme")
    let label = Size.large.rawValue

    let sizes = Size.allCases.count
    let names = Size.allCases.map { $0.rawValue }

    let inside = describe(.table(4))
    let home = describe(.delivery(address: "via Roma 1"))
    let quick = describe(.takeaway)
}
