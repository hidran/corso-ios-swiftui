//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var showDialog = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Apri il pannello") {
                showSheet = true
            }
            Button("Svuota il carrello", role: .destructive) {
                showAlert = true
            }
            Button("Condividi") {
                showDialog = true
            }
        }
        .buttonStyle(.bordered)
        .padding()
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 20) {
                Text("Il tuo ordine")
                    .font(.title)
                Button("Chiudi") {
                    showSheet = false
                }
            }
            .presentationDetents([.medium])
        }
        .alert("Svuotare il carrello?", isPresented: $showAlert) {
            Button("Svuota", role: .destructive) { }
            Button("Annulla", role: .cancel) { }
        } message: {
            Text("L'operazione non si può annullare.")
        }
        .confirmationDialog("Condividi con",
                            isPresented: $showDialog) {
            Button("Messaggi") { }
            Button("Mail") { }
        }
    }
}

#Preview {
    ContentView()
}
