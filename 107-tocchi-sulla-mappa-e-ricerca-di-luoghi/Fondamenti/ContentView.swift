//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import MapKit

extension MKCoordinateRegion {
    static let rome = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.8986, longitude: 12.4769
        ),
        latitudinalMeters: 1500,
        longitudinalMeters: 1500
    )
}

struct ContentView: View {
    @State private var position = MapCameraPosition.region(.rome)
    @State private var pin: CLLocationCoordinate2D?
    @State private var address = "Tocca la mappa"
    @State private var shops: [MKMapItem] = []

    var body: some View {
        VStack {
            MapReader { proxy in
                Map(position: $position) {
                    if let pin {
                        Marker("Qui", coordinate: pin)
                    }
                    ForEach(shops, id: \.self) { shop in
                        Marker(item: shop)
                    }
                }
                .onTapGesture { point in
                    pin = proxy.convert(point, from: .local)
                    Task { await findAddress() }
                }
            }
            Text(address)
                .font(.headline)
            Button("Gelaterie qui vicino") {
                Task { await findShops() }
            }
            .buttonStyle(.borderedProminent)
            Text("Gelaterie trovate: \(shops.count)")
        }
    }

    func findAddress() async {
        guard let pin else { return }
        let spot = CLLocation(
            latitude: pin.latitude, longitude: pin.longitude
        )
        let request = MKReverseGeocodingRequest(location: spot)
        let places = try? await request?.mapItems
        let found = places?.first?.address?.shortAddress
        address = found ?? "Indirizzo non trovato"
    }

    func findShops() async {
        guard let pin else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gelateria"
        request.region = MKCoordinateRegion(
            center: pin,
            latitudinalMeters: 800,
            longitudinalMeters: 800
        )
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        shops = response?.mapItems ?? []
    }
}

#Preview {
    ContentView()
}
