//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Conteggio: \(count)")
                .font(.largeTitle)
            HStack {
                Button("Meno", systemImage: "minus") {
                    count -= 1
                }
                .disabled(count == 0)
                Button("Più", systemImage: "plus") {
                    count += 1
                }
            }
            .buttonStyle(.bordered)
            Button("Azzera", role: .destructive) {
                count = 0
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
