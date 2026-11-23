//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var position = MapCameraPosition.automatic
    @State private var isFollowing = false
    @State private var message = "Posizione non ancora richiesta"

    var buttonTitle: String {
        isFollowing ? "Ferma" : "Segui la mia posizione"
    }

    var body: some View {
        VStack {
            Map(position: $position) {
                UserAnnotation()
            }
            Text(message)
                .font(.headline)
            Button(buttonTitle) {
                isFollowing.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .task(id: isFollowing) {
            if isFollowing {
                try? await follow()
            }
        }
    }

    func follow() async throws {
        position = .userLocation(fallback: .automatic)
        for try await update in CLLocationUpdate.liveUpdates() {
            if update.authorizationDenied {
                message = "Posizione negata"
            }
            if let location = update.location {
                message = describe(location)
            }
        }
    }

    func describe(_ location: CLLocation) -> String {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        return String(format: "%.4f, %.4f", latitude, longitude)
    }
}

#Preview {
    ContentView()
}
