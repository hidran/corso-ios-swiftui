//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var todos = Todo.samples

    var body: some View {
        NavigationStack {
            List(todos) { todo in
                TodoRow(todo: todo)
            }
            .navigationTitle("Cose da fare")
        }
    }
}

#Preview {
    ContentView()
}
