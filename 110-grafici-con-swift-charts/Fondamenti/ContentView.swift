//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import Charts

struct Reading: Identifiable {
    let id = UUID()
    let month: String
    let degrees: Double
}

let readings = [
    Reading(month: "Gen", degrees: 8),
    Reading(month: "Feb", degrees: 9),
    Reading(month: "Mar", degrees: 12),
    Reading(month: "Apr", degrees: 15),
    Reading(month: "Mag", degrees: 19),
    Reading(month: "Giu", degrees: 24),
    Reading(month: "Lug", degrees: 27),
    Reading(month: "Ago", degrees: 27),
    Reading(month: "Set", degrees: 23),
    Reading(month: "Ott", degrees: 18),
    Reading(month: "Nov", degrees: 13),
    Reading(month: "Dic", degrees: 9),
]

struct ContentView: View {
    var average: Double {
        let total = readings.reduce(0) { $0 + $1.degrees }
        return total / Double(readings.count)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Temperature a Roma")
                .font(.title2)
            Chart {
                ForEach(readings) { reading in
                    AreaMark(
                        x: .value("Mese", reading.month),
                        y: .value("Gradi", reading.degrees)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.orange.opacity(0.2))
                    LineMark(
                        x: .value("Mese", reading.month),
                        y: .value("Gradi", reading.degrees)
                    )
                    .interpolationMethod(.catmullRom)
                    PointMark(
                        x: .value("Mese", reading.month),
                        y: .value("Gradi", reading.degrees)
                    )
                }
                RuleMark(y: .value("Media", average))
                    .foregroundStyle(.red)
                    .annotation(position: .top) {
                        Text("Media")
                    }
            }
            .chartYScale(domain: 0...35)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYAxisLabel("Gradi")
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 6)
            .frame(height: 300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
