//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var margherita = 1
    @State private var diavola = 0

    var body: some View {
        VStack(spacing: 20) {
            QuantityRow(name: "Margherita", quantity: $margherita)
            QuantityRow(name: "Diavola", quantity: $diavola)
            Text("Totale: \(margherita + diavola) pizze")
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

struct QuantityRow: View {
    let name: String
    @Binding var quantity: Int

    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Button("Meno", systemImage: "minus") {
                quantity -= 1
            }
            Text("\(quantity)")
            Button("Più", systemImage: "plus") {
                quantity += 1
            }
        }
    }
}

#Preview {
    ContentView()
}
