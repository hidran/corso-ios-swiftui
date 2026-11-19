//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var people = 2
    let total = 60.0

    var share: Double {
        total / Double(people)
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Siamo in \(people)")
                .font(.largeTitle)
            Text(share, format: .currency(code: "EUR"))
                .font(.title)
            PeopleCounter(people: $people)
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

struct PeopleCounter: View {
    @Binding var people: Int

    var body: some View {
        HStack(spacing: 20) {
            Button("Meno") {
                people -= 1
            }
            Text("\(people)")
            Button("Più") {
                people += 1
            }
        }
    }
}

#Preview {
    ContentView()
}
