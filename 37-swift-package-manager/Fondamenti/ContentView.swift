//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @State private var party = 0

    var body: some View {
        Button("Festeggia") {
            party += 1
        }
        .font(.largeTitle)
        .buttonStyle(.bordered)
        .confettiCannon(trigger: $party, confettis: [.text("🍕")])
    }
}

#Preview {
    ContentView()
}
