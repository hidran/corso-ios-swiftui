//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Novità")
                .badge()
            Text("Offerta")
                .badge()
            Button("Aggiungi al carrello") { }
                .buttonStyle(PillButtonStyle())
        }
        .padding()
    }
}

struct Badge: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(8)
            .background(.orange, in: .capsule)
    }
}

extension View {
    func badge() -> some View {
        modifier(Badge())
    }
}

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue, in: .capsule)
            .foregroundStyle(.white)
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

#Preview {
    ContentView()
}
