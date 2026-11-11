//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("montagna")
                .resizable()
                .scaledToFit()
            Text("Gita in montagna")
                .font(.title)
                .fontWeight(.semibold)
            Text("Una giornata di sole, un sentiero facile e il panorama sulle cime.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Label("3 ore di cammino", systemImage: "figure.hiking")
            Image(systemName: "cloud.sun.rain.fill")
                .symbolRenderingMode(.multicolor)
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
