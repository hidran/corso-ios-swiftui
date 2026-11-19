//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isDone = false
}

struct ContentView: View {
    @State private var todos = [
        Todo(title: "Comprare il pane", isDone: true),
        Todo(title: "Chiamare la nonna"),
        Todo(title: "Portare fuori il cane", isDone: true),
        Todo(title: "Studiare SwiftUI")
    ]

    @AppStorage("bigText") private var bigText = false
    @SceneStorage("onlyToDo") private var onlyToDo = false

    var visible: [Todo] {
        if onlyToDo {
            return todos.filter { !$0.isDone }
        }
        return todos
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Testo", selection: $bigText) {
                        Text("Normale").tag(false)
                        Text("Grande").tag(true)
                    }
                    .pickerStyle(.segmented)
                    Picker("Mostra", selection: $onlyToDo) {
                        Text("Tutte").tag(false)
                        Text("Da fare").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
                ForEach(visible) { todo in
                    Text(todo.title)
                        .strikethrough(todo.isDone)
                        .font(bigText ? .title2 : .body)
                }
            }
            .navigationTitle("Cose da fare")
        }
    }
}

#Preview {
    ContentView()
}
