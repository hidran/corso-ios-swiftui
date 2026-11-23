//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude, longitude: longitude
        )
    }
}

extension Place {
    static let colosseum = Place(
        name: "Colosseo", latitude: 41.8902, longitude: 12.4922
    )
    static let pantheon = Place(
        name: "Pantheon", latitude: 41.8986, longitude: 12.4769
    )
    static let trevi = Place(
        name: "Fontana di Trevi",
        latitude: 41.9009, longitude: 12.4833
    )
    static let sights = [colosseum, pantheon, trevi]
}

struct ContentView: View {
    @State private var position = MapCameraPosition.automatic
    let hotel = CLLocationCoordinate2D(
        latitude: 41.8955, longitude: 12.4823
    )

    var body: some View {
        Map(position: $position) {
            ForEach(Place.sights) { place in
                Marker(place.name, coordinate: place.coordinate)
                    .tint(.orange)
            }
            Annotation("Hotel", coordinate: hotel) {
                Image(systemName: "bed.double.fill")
                    .padding(6)
                    .background(.yellow, in: .circle)
            }
        }
        .safeAreaInset(edge: .top) {
            Text("Una giornata a Roma")
                .font(.headline)
                .padding(8)
                .background(.thinMaterial, in: .capsule)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Vai al Colosseo") {
                    position = .region(
                        MKCoordinateRegion(
                            center: Place.colosseum.coordinate,
                            latitudinalMeters: 500,
                            longitudinalMeters: 500
                        )
                    )
                }
                Button("Mostra tutti") {
                    position = .automatic
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
