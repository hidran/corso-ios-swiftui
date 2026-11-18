//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        Text("Swift essenziale")
    }
}

struct Bill {
    var total: Double
    var note = ""
    var people: Int {
        willSet {
            note = "Da \(people) a \(newValue) persone"
        }
        didSet {
            if people < 1 {
                people = 1
            }
        }
    }
    lazy var title = "Conto per \(people)"

    var share: Double {
        return total / Double(people)
    }
}

#Playground {
    var dinner = Bill(total: 60, people: 4)
    let before = dinner.share
    dinner.people = 3
    let after = dinner.share

    dinner.people = 0
    let safe = dinner.share
    let seated = dinner.people

    dinner.people = 5
    let last = dinner.note
    let check = dinner.share

    let heading = dinner.title
    dinner.people = 2
    let now = dinner.share
    let still = dinner.title
}
