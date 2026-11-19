//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

@Observable
class Place: Identifiable {
    var name: String
    var visited = false

    init(name: String) {
        self.name = name
    }
}

@Observable
class Trip {
    var places = [Place(name: "Colosseo"),
                  Place(name: "Pantheon"),
                  Place(name: "Fontana di Trevi")]

    var visitedCount: Int {
        places.filter { $0.visited }.count
    }
}

struct PlaceRow: View {
    @Bindable var place: Place

    var body: some View {
        Toggle(place.name, isOn: $place.visited)
            .toggleStyle(.button)
    }
}

struct Summary: View {
    @Environment(Trip.self) private var trip
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("\(trip.visitedCount) su \(trip.places.count)")
                .font(.largeTitle)
            Text("luoghi visitati")
            Button("Fatto") {
                dismiss()
            }
        }
    }
}

struct ContentView: View {
    @State private var trip = Trip()
    @State private var showSummary = false

    var body: some View {
        NavigationStack {
            List(trip.places) { place in
                PlaceRow(place: place)
            }
            .navigationTitle("Roma")
            .navigationSubtitle("Visitati: \(trip.visitedCount)")
            .toolbar {
                Button("Riepilogo") {
                    showSummary = true
                }
            }
            .sheet(isPresented: $showSummary) {
                Summary()
            }
        }
        .environment(trip)
    }
}

#Preview {
    ContentView()
}
