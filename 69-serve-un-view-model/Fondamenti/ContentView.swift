//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

@Observable
class BillSplitter {
    var total = 60.0
    var people = 2
    var tip = 10

    var share: Double {
        let withTip = total * (1 + Double(tip) / 100)
        return withTip / Double(people)
    }

    func addPerson() {
        people += 1
    }

    func removePerson() {
        if people > 1 {
            people -= 1
        }
    }
}

struct ContentView: View {
    @State private var bill = BillSplitter()

    var body: some View {
        Form {
            Section("Conto") {
                Text(bill.total, format: .currency(code: "EUR"))
                Picker("Mancia", selection: $bill.tip) {
                    Text("0%").tag(0)
                    Text("10%").tag(10)
                    Text("20%").tag(20)
                }
                .pickerStyle(.segmented)
                HStack {
                    Text("Persone: \(bill.people)")
                    Spacer()
                    Button("Meno") {
                        bill.removePerson()
                    }
                    Button("Più") {
                        bill.addPerson()
                    }
                }
            }
            Section("A testa") {
                Text(bill.share, format: .currency(code: "EUR"))
                    .font(.largeTitle)
            }
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    ContentView()
}
