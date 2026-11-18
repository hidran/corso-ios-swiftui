//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var total = 80.0
    @State private var people = 2
    @State private var tip = 10

    var body: some View {
        let tipAmount = total * Double(tip) / 100
        let share = (total + tipAmount) / Double(people)

        VStack(spacing: 16) {
            Text("Dividi il conto")
                .font(.largeTitle)
                .bold()
            Text("Conto: \(Int(total)) euro")
            HStack {
                Button("Meno 10") {
                    if total >= 10 {
                        total -= 10
                    }
                }
                Button("Più 10") {
                    total += 10
                }
            }
            Text("Persone: \(people)")
            HStack {
                Button("Meno") {
                    if people > 1 {
                        people -= 1
                    }
                }
                Button("Più") {
                    people += 1
                }
            }
            Text("Mancia: \(tip) per cento")
            HStack {
                Button("Zero") { tip = 0 }
                Button("Dieci") { tip = 10 }
                Button("Venti") { tip = 20 }
            }
            Text("A testa")
            Text(share, format: .currency(code: "EUR"))
                .font(.largeTitle)
                .bold()
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

#Preview {
    ContentView()
}
