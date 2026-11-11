//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var size = "Media"
    @State private var quantity = 1
    @State private var spicy = 0.0
    @State private var delivery = false
    @State private var time = Date.now

    var body: some View {
        Form {
            TextField("Il tuo nome", text: $name)
            Picker("Formato", selection: $size) {
                Text("Piccola").tag("Piccola")
                Text("Media").tag("Media")
                Text("Grande").tag("Grande")
            }
            .pickerStyle(.segmented)
            Stepper("Quantità: \(quantity)",
                    value: $quantity, in: 1...10)
            Slider(value: $spicy, in: 0...10, step: 1)
            Text("Piccante: \(Int(spicy)) su 10")
            Toggle("Consegna a domicilio", isOn: $delivery)
            DatePicker("Quando", selection: $time,
                       displayedComponents: .hourAndMinute)
            Text("\(quantity) pizza \(size) per \(name)")
        }
    }
}

#Preview {
    ContentView()
}
