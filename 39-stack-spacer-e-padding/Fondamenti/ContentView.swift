//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 64))
                Text("Nuovo")
                    .font(.caption)
                    .padding(4)
                    .background(.orange)
            }
            Text("Caffè espresso")
                .font(.title2)
                .bold()
            Text("Corto, intenso, italiano")
                .foregroundStyle(.secondary)
            HStack {
                Text("1,20 €")
                Spacer()
                Image(systemName: "star.fill")
                Text("4,8")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
