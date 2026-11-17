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
    let pizzas = 7
    let people = 2
    print("A testa:", pizzas / people)
    print("Avanzano:", pizzas % people)

    let price = 8.5
    let total = price * Double(pizzas)
    print("Totale:", total)
    print("Senza decimali:", Int(total))
    print("Arrotondato:", total.rounded())

    let isBig = total > 50
    let isEven = pizzas % 2 == 0
    print(isBig, isEven)
    let isWeekend = false
    let discount = isBig && !isWeekend
    print("Sconto:", discount)

    let toPay = discount ? total - 5 : total
    print("Da pagare:", toPay)
}
