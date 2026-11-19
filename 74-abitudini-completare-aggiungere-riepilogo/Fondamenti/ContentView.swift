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

    var doneCount: Int {
        habits.filter { $0.isDone }.count
    }

    var summary: String {
        "Fatte: \(doneCount) su \(habits.count)"
    }

    func add(_ name: String) {
        habits.append(Habit(name: name, symbol: "star.fill"))
    }

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
    @AppStorage("hideDone") private var hideDone = false
    @State private var showAdd = false

    var visible: [Habit] {
        if hideDone {
            return store.habits.filter { !$0.isDone }
        }
        return store.habits
    }

    var body: some View {
        NavigationStack {
            List(visible) { habit in
                HabitRow(habit: habit)
                    .swipeActions {
                        Button("Elimina", role: .destructive) {
                            store.remove(habit)
                        }
                    }
            }
            .navigationTitle("Abitudini")
            .navigationSubtitle(store.summary)
            .toolbar {
                Button(hideDone ? "Tutte" : "Solo da fare") {
                    hideDone.toggle()
                }
                Button("Aggiungi") {
                    showAdd = true
                }
            }
            .sheet(isPresented: $showAdd) {
                AddHabit()
            }
        }
    }
}

struct HabitRow: View {
    @Bindable var habit: Habit

    var body: some View {
        Toggle(isOn: $habit.isDone) {
            Label(habit.name, systemImage: habit.symbol)
        }
        .toggleStyle(.button)
        .tint(.green)
    }
}

struct AddHabit: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $name)
                    .autocorrectionDisabled()
            }
            .navigationTitle("Nuova abitudine")
            .toolbar {
                Button("Salva") {
                    store.add(name)
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
    }
}

#Preview {
    ContentView()
}
