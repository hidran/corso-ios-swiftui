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
    let typed = "12"
    let quantity = Int(typed)
    let wrongText = "dodici"
    let wrong = Int(wrongText)
    if let quantity {
        print("Il doppio:", quantity * 2)
    }
    if let wrong {
        print("Il numero è", wrong)
    } else {
        print("Non è un numero:", wrongText)
    }

    let guests = Int("tre") ?? 1
    print("Ospiti:", guests)
    let prices = ["Margherita": 6.5]
    let price = prices["Diavola"] ?? 0
    print("Prezzo:", price)

    var note: String? = "senza cipolla"
    print("Lettere:", note?.count ?? 0)
    note = nil
    print("Lettere:", note?.count ?? 0)
}
