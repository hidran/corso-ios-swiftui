//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(1...30, id: \.self) { number in
                    Text("Riga \(number)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue.gradient, in: .capsule)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
