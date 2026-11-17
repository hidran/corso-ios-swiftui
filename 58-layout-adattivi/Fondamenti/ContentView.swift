//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(iOS 27.1, *) {
            ArrangementView {
                PizzaView()
                    .splitArrangementLayoutRatio(0.3)
            } secondary: {
                IngredientsView()
            }
            .arrangementViewStyle(.split)
        } else {
            VStack(spacing: 0) {
                PizzaView()
                IngredientsView()
            }
        }
    }
}

struct PizzaView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "fork.knife")
                .font(.system(size: 60))
            Text("Margherita")
                .font(.largeTitle.bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange.gradient)
    }
}

struct IngredientsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredienti")
                .font(.title.bold())
            Text("Pomodoro")
            Text("Mozzarella")
            Text("Basilico")
        }
        .font(.title2)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow.opacity(0.3))
    }
}

#Preview {
    ContentView()
}
