//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dynamicTypeSize) private var typeSize

    var layout: AnyLayout {
        if typeSize.isAccessibilitySize {
            AnyLayout(VStackLayout(alignment: .leading))
        } else {
            AnyLayout(HStackLayout(spacing: 16))
        }
    }

    var body: some View {
        layout {
            Image(systemName: "leaf.fill")
                .font(.largeTitle)
                .foregroundStyle(.green)
                .accessibilityLabel("Vegetariana")
            VStack(alignment: .leading, spacing: 4) {
                Text("Margherita")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text("Pomodoro, mozzarella e basilico")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)
            Button("Preferita", systemImage: "heart") { }
                .labelStyle(.iconOnly)
        }
        .padding()
        .background(.background.secondary,
                    in: RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.accessibility5)
}
