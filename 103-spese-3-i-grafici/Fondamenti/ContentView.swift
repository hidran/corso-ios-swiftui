//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import SwiftData
import Charts

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

    var price: String {
        (Double(cents) / 100).formatted(.currency(code: "EUR"))
    }

    var month: Date {
        let calendar = Calendar.current
        let span = calendar.dateInterval(of: .month, for: date)
        return span?.start ?? date
    }

    var label: String {
        "\(title) · \(category)"
    }

    var euros: Double {
        Double(cents) / 100
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
    @State private var filter = ""

    var body: some View {
        NavigationStack {
            ExpenseList(category: filter)
                .navigationTitle("Spese")
                .toolbar {
                    Button("Aggiungi") { isAdding = true }
                    NavigationLink("Grafici") {
                        StatsView()
                    }
                }
                .sheet(isPresented: $isAdding) {
                    AddExpense()
                }
                .safeAreaInset(edge: .bottom) {
                    Picker("Filtro", selection: $filter) {
                        Text("Tutte").tag("")
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
        }
    }
}

struct ExpenseList: View {
    @Query private var expenses: [Expense]

    init(category: String) {
        _expenses = Query(
            filter: #Predicate<Expense> {
                category.isEmpty || $0.category == category
            },
            sort: \Expense.date, order: .reverse
        )
    }

    var months: [Date] {
        Set(expenses.map { $0.month }).sorted(by: >)
    }

    func items(_ month: Date) -> [Expense] {
        expenses.filter { $0.month == month }
    }

    var body: some View {
        List {
            ForEach(months, id: \.self) { month in
                MonthSection(month: month, items: items(month))
            }
        }
        .navigationDestination(for: Expense.self) {
            EditExpense(expense: $0)
        }
    }
}

struct MonthSection: View {
    @Environment(\.modelContext) private var context
    let month: Date
    let items: [Expense]

    var body: some View {
        Section {
            ForEach(items) { item in
                NavigationLink(value: item) {
                    LabeledContent(item.label, value: item.price)
                }
                .swipeActions {
                    Button("Elimina", role: .destructive) {
                        context.delete(item)
                    }
                }
            }
        } header: {
            Text(month, format: .dateTime.month(.wide).year())
        }
    }
}

struct EditExpense: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense

    var body: some View {
        Form {
            TextField("Descrizione", text: $expense.title)
            Picker("Categoria", selection: $expense.category) {
                ForEach(categories, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            Button("Fine") { dismiss() }
        }
        .navigationTitle("Modifica")
    }
}

struct StatsView: View {
    @Query private var expenses: [Expense]

    var body: some View {
        List {
            Text("Per categoria")
            Chart(expenses) { item in
                BarMark(
                    x: .value("Categoria", item.category),
                    y: .value("Euro", item.euros)
                )
            }
            .frame(height: 180)
            Text("Per mese")
            Chart(expenses) { item in
                BarMark(
                    x: .value("Mese", item.month, unit: .month),
                    y: .value("Euro", item.euros)
                )
            }
            .frame(height: 180)
        }
        .navigationTitle("Riepilogo")
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

@MainActor
func seed(_ result: Result<ModelContainer, Error>) {
    guard let container = try? result.get() else { return }
    let samples = [
        Expense(title: "Luce", cents: 8000, category: "Casa"),
        Expense(title: "Pizza", cents: 1200, category: "Cibo"),
        Expense(title: "Treno", cents: 2350, category: "Viaggi"),
    ]
    let past = Calendar.current.date(
        byAdding: .month, value: -1, to: .now
    )
    samples[2].date = past ?? .now
    for expense in samples {
        container.mainContext.insert(expense)
    }
}

#Preview {
    ExpenseScreen()
        .modelContainer(for: Expense.self, inMemory: true) {
            seed($0)
        }
}
