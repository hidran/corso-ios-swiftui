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

enum OrderError: Error {
    case soldOut(String)
    case unknown(String)
}

func price(of pizza: String) throws(OrderError) -> Double {
    if pizza == "Capricciosa" {
        throw OrderError.soldOut(pizza)
    }
    let menu = ["Margherita": 6.5, "Diavola": 8.5]
    guard let euro = menu[pizza] else {
        throw OrderError.unknown(pizza)
    }
    return euro
}

#Playground {
    let hawaii = try? price(of: "Hawaiana")
    let diavola = try? price(of: "Diavola")

    do {
        let total = try price(of: "Hawaiana")
        print("Totale: \(total)")
    } catch OrderError.unknown(let name) {
        print("Non abbiamo la \(name)")
    } catch {
        print("Errore: \(error)")
    }

    do throws(OrderError) {
        _ = try price(of: "Capricciosa")
    } catch {
        switch error {
        case .soldOut(let name):
            print("Finita la \(name)")
        case .unknown(let name):
            print("Non c'è la \(name)")
        }
    }

    let result = Result { try price(of: "Margherita") }
    switch result {
    case .success(let euro):
        print("Costa \(euro) euro")
    case .failure(let error):
        print("Errore: \(error)")
    }
}
