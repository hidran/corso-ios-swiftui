//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var currencyCode = "EUR"
}

extension View {
    func currencyCode(_ code: String) -> some View {
        environment(\.currencyCode, code)
    }
}

struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
}

struct ExpenseRow: View {
    let expense: Expense
    @Environment(\.currencyCode) private var currencyCode

    var body: some View {
        HStack {
            Text(expense.name)
            Spacer()
            Text(expense.amount,
                 format: .currency(code: currencyCode))
        }
    }
}

struct ContentView: View {
    let rome = [Expense(name: "Cena", amount: 60),
                Expense(name: "Museo", amount: 18)]
    let london = [Expense(name: "Cena", amount: 45),
                  Expense(name: "Metro", amount: 8.5)]

    var body: some View {
        NavigationStack {
            List {
                Section("Roma") {
                    ForEach(rome) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
                Section("Londra") {
                    ForEach(london) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
                .currencyCode("GBP")
            }
            .navigationTitle("Spese di viaggio")
        }
    }
}

#Preview {
    ContentView()
}
