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
    let name = "Anna"
    let age = 31
    var message = "Ciao \(name), hai \(age) anni"
    message += " e l'anno prossimo \(age + 1)"

    let receipt = """
        Ordine di \(name)
        Pizze: 2
        """
    print(receipt)

    let word = "caffè"
    print("Lettere:", word.count)
    let flag = "🇮🇹"
    print("Bandiera:", flag.count, flag.unicodeScalars.count)

    print(name.uppercased())
    print(message.hasPrefix("Ciao"))
    print(message.contains("Luca"))
    print(word.isEmpty)
}
