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
    let minutesPerHour = 60
    let minutesPerDay = minutesPerHour * 24
    print("Un giorno ha", minutesPerDay, "minuti")
    let minutesPerWeek = minutesPerDay * 7
    print("Una settimana ha", minutesPerWeek, "minuti")
}
