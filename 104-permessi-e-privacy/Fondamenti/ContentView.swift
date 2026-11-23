//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import CoreLocation

enum LocationAccess {
    case unknown, allowed, denied
}

struct ContentView: View {
    @State private var access = LocationAccess.unknown

    var message: String {
        switch access {
        case .unknown: "Posizione non ancora richiesta"
        case .allowed: "Posizione consentita"
        case .denied: "Posizione negata"
        }
    }

    var settings: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 60))
            Text("Negozi vicini")
                .font(.title)
            Button("Cerca vicino a me") {
                Task { try? await askForLocation() }
            }
            .buttonStyle(.borderedProminent)
            Text(message)
            if access == .denied, let settings {
                Link("Apri Impostazioni", destination: settings)
            }
        }
        .padding()
    }

    func askForLocation() async throws {
        let session = CLServiceSession(authorization: .whenInUse)
        for try await diagnostic in session.diagnostics {
            if !diagnostic.authorizationRequestInProgress {
                let denied = diagnostic.authorizationDenied
                access = denied ? .denied : .allowed
                return
            }
        }
    }
}

#Preview {
    ContentView()
}
