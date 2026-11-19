//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

@Observable
class TaskList {
    var tasks = ["Comprare il pane", "Studiare Swift"]

    func add() {
        tasks.append("Cosa numero \(tasks.count + 1)")
    }

    func clear() {
        tasks.removeAll()
    }
}

struct TaskCounter: View {
    let list: TaskList

    var body: some View {
        HStack {
            Text("Da fare: \(list.tasks.count)")
            Spacer()
            Button("Svuota") {
                list.clear()
            }
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var list = TaskList()

    var body: some View {
        NavigationStack {
            VStack {
                List(list.tasks, id: \.self) { task in
                    Text(task)
                }
                TaskCounter(list: list)
            }
            .navigationTitle("Cose da fare")
            .toolbar {
                Button("Aggiungi") {
                    list.add()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
