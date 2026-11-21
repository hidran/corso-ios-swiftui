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
        NavigationStack {
            ExpenseEditor()
        }
        .modelContainer(for: Expense.self, inMemory: true)
    }
}

struct ExpenseEditor: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Expense.title) private var expenses: [Expense]
    @State private var message = ""

    var body: some View {
        List {
            ForEach(expenses) { expense in
                Text(expense.title)
            }
            if expenses.isEmpty {
                Text("Ancora nessuna spesa")
            }
            Text(message)
        }
        .navigationTitle("Registro delle spese")
        .toolbar {
            Button("Aggiungi") { add() }
            if let expense = expenses.first {
                Button("Modifica") { rename(expense) }
                Button("Elimina", role: .destructive) { remove(expense) }
            }
        }
    }

    private func add() {
        let expense = Expense(title: "Caffè", amountCents: 150, category: "Cibo")
        context.insert(expense)
        saveChange("Spesa aggiunta")
    }

    private func rename(_ expense: Expense) {
        expense.title = "Caffè doppio"
        saveChange("Spesa modificata")
    }

    private func remove(_ expense: Expense) {
        context.delete(expense)
        saveChange("Spesa eliminata")
    }

    private func saveChange(_ success: String) {
        do {
            try context.save()
            message = success
        } catch {
            context.rollback()
            message = "Operazione non riuscita"
        }
    }
}

#Preview {
    ContentView()
}
