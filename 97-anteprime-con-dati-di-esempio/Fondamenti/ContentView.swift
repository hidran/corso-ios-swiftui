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
    var category: String

    init(title: String, amountCents: Int, category: String) {
        self.title = title
        self.amountCents = amountCents
        self.category = category
    }
}

struct ContentView: View {
    var body: some View {
        ExpensesView()
            .modelContainer(for: Expense.self)
    }
}

struct ExpensesView: View {
    @Query(sort: \Expense.title) private var expenses: [Expense]

    var body: some View {
        NavigationStack {
            List {
                if expenses.isEmpty {
                    Text("Il registro è vuoto")
                }
                ForEach(expenses) { expense in
                    LabeledContent(expense.title, value: String(expense.amountCents))
                }
            }
            .navigationTitle("Registro delle spese")
        }
    }
}

@MainActor
func sampleContainer() -> ModelContainer? {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    guard let container = try? ModelContainer(
        for: Expense.self, configurations: config
    ) else { return nil }
    let context = container.mainContext
    context.insert(Expense(title: "Cinema", amountCents: 900, category: "Svago"))
    context.insert(Expense(title: "Pane", amountCents: 230, category: "Cibo"))
    do {
        try context.save()
        return container
    } catch {
        return nil
    }
}

#Preview("Vuoto") {
    ExpensesView()
        .modelContainer(for: Expense.self, inMemory: true)
}

#Preview("Con dati") {
    if let container = sampleContainer() {
        ExpensesView()
            .modelContainer(container)
    } else {
        Text("Anteprima non disponibile")
    }
}
