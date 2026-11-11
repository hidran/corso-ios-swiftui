//
//  ContentView.swift
//  PrimaApp
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var likes = 0

    var body: some View {
        VStack {
            Image(systemName: "swift")
                .imageScale(.large)
                .foregroundStyle(.orange)
            Text("Ciao, SwiftUI!")
                .font(.largeTitle)
                .bold()
            Text("Mi piace: \(likes)")
            Button("Mi piace") {
                likes += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
