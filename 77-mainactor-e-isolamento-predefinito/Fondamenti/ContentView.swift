//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var result = "Nessun calcolo"
    @State private var isWorking = false

    var body: some View {
        VStack(spacing: 24) {
            if isWorking {
                ProgressView("Sto contando...")
            } else {
                Text(result)
                    .font(.title2)
            }
            Button("Conta i multipli di 7") {
                Task {
                    isWorking = true
                    await countMultiples(upTo: 20_000_000)
                }
            }
            .buttonStyle(.bordered)
        }
    }

    @concurrent
    func countMultiples(upTo limit: Int) async {
        var count = 0
        for n in 1...limit {
            if n % 7 == 0 {
                count += 1
            }
        }
        await showResult(count)
    }

    func showResult(_ count: Int) {
        result = "Multipli di 7: \(count)"
        isWorking = false
    }
}

#Preview {
    ContentView()
}
