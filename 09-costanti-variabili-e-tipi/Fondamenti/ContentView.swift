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
    var name = "Anna"
    var age = 30
    age += 1
    name = "Luca"
    age = 32
    print(name, "ha", age, "anni")

    let city: String = "Roma"
    var temperature: Double = 20
    temperature += 1.5
    let isOpen: Bool = true
    print(city, temperature, isOpen)
}
