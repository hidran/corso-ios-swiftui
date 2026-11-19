//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

@Observable
class Habit: Identifiable {
    let id = UUID()
    var name: String
    var symbol: String
    var isDone = false

    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
    }
}

@Observable
class HabitStore {
    var habits = [
        Habit(name: "Bere acqua", symbol: "drop.fill"),
        Habit(name: "Leggere", symbol: "book.fill"),
        Habit(name: "Camminare", symbol: "figure.walk"),
        Habit(name: "Meditare", symbol: "leaf.fill")
    ]

    func remove(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
    }
}

struct ContentView: View {
    @State private var store = HabitStore()

    var body: some View {
        HabitList()
            .environment(store)
    }
}

struct HabitList: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        NavigationStack {
            List(store.habits) { habit in
                HabitRow(habit: habit)
                    .swipeActions {
                        Button("Elimina", role: .destructive) {
                            store.remove(habit)
                        }
                    }
            }
            .navigationTitle("Abitudini")
        }
    }
}

struct HabitRow: View {
    let habit: Habit

    var body: some View {
        Label(habit.name, systemImage: habit.symbol)
    }
}

#Preview {
    ContentView()
}
