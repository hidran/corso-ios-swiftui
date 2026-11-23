//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import UserNotifications

class Presenter: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
}

let presenter = Presenter()

struct ContentView: View {
    @State private var message = "Promemoria spento"

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
            Button("Attiva promemoria") {
                Task { await remind() }
            }
        }
        .padding()
    }

    private func remind() async {
        let center = UNUserNotificationCenter.current()
        center.delegate = presenter
        do {
            let granted = try await center.requestAuthorization(
                options: [.alert, .sound]
            )
            guard granted else {
                message = "Permesso negato"
                return
            }
            let content = UNMutableNotificationContent()
            content.title = "Spese"
            content.body = "Hai annotato le spese di oggi?"
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5, repeats: false
            )
            let request = UNNotificationRequest(
                identifier: "promemoria",
                content: content, trigger: trigger
            )
            try await center.add(request)
            message = "Promemoria tra 5 secondi"
        } catch {
            message = "Promemoria non impostato"
        }
    }
}

#Preview {
    ContentView()
}
