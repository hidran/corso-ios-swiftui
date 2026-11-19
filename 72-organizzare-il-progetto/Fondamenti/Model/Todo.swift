//
//  Todo.swift
//  Fondamenti
//
//  Created by the studio on 11/18/26.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isDone = false
}

extension Todo {
    static let samples = [
        Todo(title: "Comprare il pane", isDone: true),
        Todo(title: "Chiamare la nonna"),
        Todo(title: "Portare fuori il cane", isDone: true),
        Todo(title: "Studiare SwiftUI")
    ]
}
