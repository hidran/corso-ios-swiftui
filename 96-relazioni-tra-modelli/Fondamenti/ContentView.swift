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
    var category: ExpenseCategory?

    init(title: String, amountCents: Int) {
        self.title = title
        self.amountCents = amountCents
    }
}

@Model
final class ExpenseCategory {
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Expense.category)
    var expenses: [Expense] = []

    init(name: String) {
        self.name = name
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            CategoryDemo()
        }
        .modelContainer(for: [Expense.self, ExpenseCategory.self], inMemory: true)
    }
}

struct CategoryDemo: View {
    @Environment(\.modelContext) private var context
    @Query private var expenses: [Expense]
    @Query private var categories: [ExpenseCategory]
    @State private var message = "Archivio vuoto"

    var body: some View {
        List {
            ForEach(categories) { category in
                Text(category.name)
            }
            ForEach(expenses) { expense in
                let categoryName = expense.category?.name ?? "Senza categoria"
                Text(expense.title + " · " + categoryName)
            }
            Text(message)
        }
        .navigationTitle("Spese e categorie")
        .toolbar {
            if expenses.isEmpty {
                Button("Prepara esempio") { seed() }
            } else if let category = categories.first {
                Button("Elimina categoria") { remove(category) }
            }
        }
    }

    private func seed() {
        let category = ExpenseCategory(name: "Viaggi")
        let expense = Expense(title: "Treno", amountCents: 1500)
        context.insert(category)
        context.insert(expense)
        expense.category = category
        persist("Dati pronti")
    }

    private func remove(_ category: ExpenseCategory) {
        context.delete(category)
        persist("Categoria eliminata")
    }

    private func persist(_ success: String) {
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
