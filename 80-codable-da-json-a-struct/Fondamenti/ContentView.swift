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

let pikachuJSON = """
{
    "name": "Pikachu",
    "height": 4,
    "base_experience": 112,
    "types": [
        { "slot": 1, "type": { "name": "electric" } }
    ],
    "caught_at": "2026-11-19T10:30:00Z"
}
"""

struct TypeInfo: Decodable {
    let name: String
}

struct TypeSlot: Decodable {
    let type: TypeInfo
}

struct Pokemon: Decodable {
    let name: String
    let height: Int
    let baseExperience: Int
    let types: [TypeSlot]
    let caughtAt: Date

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case baseExperience = "base_experience"
        case types
        case caughtAt = "caught_at"
    }
}

#Playground {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let data = Data(pikachuJSON.utf8)

    do {
        let pikachu = try decoder.decode(Pokemon.self, from: data)
        print("\(pikachu.name), altezza \(pikachu.height)")
        print("Esperienza: \(pikachu.baseExperience)")
        print("Tipo: \(pikachu.types[0].type.name)")
        let day = pikachu.caughtAt
        let italiano = Locale(identifier: "it_IT")
        let style = Date.FormatStyle(date: .long, locale: italiano)
        print(day.formatted(style))
    } catch {
        print("Errore: \(error)")
    }
}
