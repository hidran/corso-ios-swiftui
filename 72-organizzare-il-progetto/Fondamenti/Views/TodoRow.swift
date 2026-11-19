//
//  TodoRow.swift
//  Fondamenti
//
//  Created by the studio on 11/18/26.
//

import SwiftUI

struct TodoRow: View {
    let todo: Todo

    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
                .opacity(todo.isDone ? 1 : 0.2)
            Text(todo.title)
                .strikethrough(todo.isDone)
        }
    }
}
