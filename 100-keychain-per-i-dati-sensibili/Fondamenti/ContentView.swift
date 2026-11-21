//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import Security

enum KeychainFailure: Error {
    case status(OSStatus)
}

enum DemoKeychain {
    // Unique per preview process to avoid affecting any existing item.
    static let service = "it.swiftcourse.demo." + UUID().uuidString

    static var identity: [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: "sample-account"
        ]
    }

    static func save(_ value: Data) throws {
        var item = identity
        item[kSecValueData as String] = value
        item[kSecAttrAccessible as String] =
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        let status = SecItemAdd(item as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainFailure.status(status)
        }
    }

    static func exists() throws -> Bool {
        let status = SecItemCopyMatching(identity as CFDictionary, nil)
        if status == errSecItemNotFound { return false }
        guard status == errSecSuccess else {
            throw KeychainFailure.status(status)
        }
        return true
    }

    static func remove() throws {
        let status = SecItemDelete(identity as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound
        else { throw KeychainFailure.status(status) }
    }
}

struct ContentView: View {
    @State private var message = "Portachiavi di prova"

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
            Button("Prova Keychain") {
                do {
                    try DemoKeychain.remove()
                    defer { try? DemoKeychain.remove() }
                    try DemoKeychain.save(Data("valore-di-prova".utf8))
                    let saved = try DemoKeychain.exists()
                    message = saved ? "Voce presente" : "Voce mancante"
                } catch {
                    message = "Portachiavi non disponibile"
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
