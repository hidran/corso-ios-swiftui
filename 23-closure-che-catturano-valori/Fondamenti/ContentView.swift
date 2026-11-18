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

func discount(percent: Double) -> (Double) -> Double {
    func apply(_ price: Double) -> Double {
        return price - price * percent / 100
    }
    return apply
}

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

#Playground {
    let tenOff = discount(percent: 10)
    let price = tenOff(20)
    let halfOff = discount(percent: 50)
    let sale = halfOff(20)

    let nextTicket = makeCounter()
    let first = nextTicket()
    let second = nextTicket()
    let third = nextTicket()

    let terrace = makeCounter()
    let again = terrace()
    let fourth = nextTicket()
}
