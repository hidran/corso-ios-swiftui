//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Recipe: Codable {
    let title: String
}

enum RecipeFile {
    static func location() throws -> URL {
        let directory = URL.applicationSupportDirectory
            .appending(path: "RecipeDemo", directoryHint: .isDirectory)
        try FileManager.default.createDirectory(
            at: directory, withIntermediateDirectories: true
        )
        return directory.appending(path: "recipe.json")
    }

    static func save(_ recipe: Recipe) throws {
        let bytes = try JSONEncoder().encode(recipe)
        let url = try location()
        try bytes.write(to: url, options: .atomic)
    }

    static func read() throws -> Recipe {
        let url = try location()
        let bytes = try Data(contentsOf: url)
        return try JSONDecoder().decode(Recipe.self, from: bytes)
    }
}

struct ContentView: View {
    @State private var title = "Zuppa di ceci"
    @State private var status = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Titolo", text: $title)
                Button("Svuota campo") {
                    title = ""
                    status = "Campo vuoto"
                }
                Button("Salva ricetta") {
                    do {
                        try RecipeFile.save(Recipe(title: title))
                        status = "Salvata: \(title)"
                    } catch {
                        status = "Salvataggio non riuscito"
                    }
                }
                Button("Rileggi dal file") {
                    do {
                        let recipe = try RecipeFile.read()
                        title = recipe.title
                        status = "Riletta: \(title)"
                    } catch {
                        status = "Lettura non riuscita"
                    }
                }
                Text(status)
            }
            .navigationTitle("La ricetta")
        }
    }
}

#Preview {
    ContentView()
}
