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
    var title = ""
    var cents = 0
    var category = "Cibo"
    var date = Date.now

    init(title: String, cents: Int, category: String) {
        self.title = title
        self.cents = cents
        self.category = category
    }
}

let categories = ["Cibo", "Casa", "Viaggi", "Svago"]

struct ContentView: View {
    var body: some View {
        ExpenseScreen()
            .modelContainer(for: Expense.self)
    }
}

struct ExpenseScreen: View {
    @State private var isAdding = false

    var body: some View {
        NavigationStack {
            ExpenseList()
                .navigationTitle("Spese")
                .toolbar {
                    Button("Aggiungi") { isAdding = true }
                }
                .sheet(isPresented: $isAdding) {
                    AddExpense()
                }
        }
    }
}

struct ExpenseList: View {
    @Query private var expenses: [Expense]

    var body: some View {
        List {
            ForEach(expenses) { expense in
                Text("\(expense.title) \(expense.cents)")
            }
        }
    }
}

struct AddExpense: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var amount = ""
    @State private var category = "Cibo"

    var body: some View {
        Form {
            TextField("Descrizione", text: $title)
            TextField("Importo in euro", text: $amount)
            Picker("Categoria", selection: $category) {
                ForEach(categories, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            Button("Salva") { save() }
        }
    }

    private func save() {
        let raw = amount.replacingOccurrences(of: ",", with: ".")
        guard let euros = Double(raw), euros > 0 else { return }
        let expense = Expense(
            title: title, cents: Int((euros * 100).rounded()),
            category: category
        )
        context.insert(expense)
        dismiss()
    }
}

#Preview {
    ExpenseScreen()
        .modelContainer(for: Expense.self, inMemory: true)
}
