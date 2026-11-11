//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Gita in montagna")
                .font(.title2)
                .padding()
                .glassEffect(.regular.tint(.orange).interactive())
            HStack {
                Button("Mappa", systemImage: "map") { }
                    .buttonStyle(.glass)
                Button("Parti", systemImage: "figure.hiking") { }
                    .buttonStyle(.glassProminent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("montagna")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
