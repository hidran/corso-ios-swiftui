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
            Circle()
                .fill(.orange.gradient)
                .frame(width: 100, height: 100)
            RoundedRectangle(cornerRadius: 20)
                .stroke(.pink, lineWidth: 4)
                .frame(width: 160, height: 80)
            Text("Colori e forme")
                .font(.title2)
                .padding()
                .background(.ultraThinMaterial, in: .capsule)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.linearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    ContentView()
}
