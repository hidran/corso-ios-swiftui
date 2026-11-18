//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import Playgrounds

struct ContentView: View {
    @State private var visits = 0

    var body: some View {
        Text("Swift essenziale")
    }
}

@propertyWrapper
struct UpToFive {
    var wrappedValue = 1 {
        didSet {
            if wrappedValue > 5 {
                wrappedValue = 5
            }
        }
    }
}

struct Review {
    let pizza: String
    @UpToFive var stars = 1
}

@Observable
class Oven {
    var temperature = 20
}

#Playground {
    var review = Review(pizza: "Diavola")
    review.stars = 9
    let stars = review.stars
    review.stars = 3
    let now = review.stars

    let oven = Oven()
    oven.temperature = 250
    let hot = oven.temperature

    let file = #fileID
}
