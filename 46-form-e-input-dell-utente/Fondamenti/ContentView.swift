//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @FocusState private var phoneFocused: Bool

    var body: some View {
        Form {
            Section("I tuoi dati") {
                TextField("Nome", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onSubmit {
                        phoneFocused = true
                    }
                TextField("Telefono", text: $phone)
                    .keyboardType(.numberPad)
                    .focused($phoneFocused)
            }
            Section {
                Button("Invia") {
                    phoneFocused = false
                }
                .disabled(name.isEmpty || phone.isEmpty)
            }
        }
    }
}

#Preview {
    ContentView()
}
