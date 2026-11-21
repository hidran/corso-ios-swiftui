//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import SwiftData

@Model
final class Expense {
    var title: String
    var amountCents: Int

    init(title: String, amountCents: Int) {
        self.title = title
        self.amountCents = amountCents
    }
}

struct ContentView: View {
    let example = Expense(title: "Caffè", amountCents: 250)

    var body: some View {
        NavigationStack {
            Form {
                Section("Spesa di esempio") {
                    LabeledContent("Descrizione", value: example.title)
                    LabeledContent(
                        "Importo in centesimi",
                        value: String(example.amountCents)
                    )
                }
            }
            .navigationTitle("Registro delle spese")
        }
        .modelContainer(for: Expense.self)
    }
}

#Preview {
    ContentView()
}
