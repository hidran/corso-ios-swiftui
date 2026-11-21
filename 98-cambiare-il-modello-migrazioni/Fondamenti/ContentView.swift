//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import SwiftData

enum ExpensesV1: VersionedSchema {
    static let versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] { [Expense.self] }

    @Model
    final class Expense {
        var title: String
        var amountCents: Int

        init(title: String, amountCents: Int) {
            self.title = title
            self.amountCents = amountCents
        }
    }
}

enum ExpensesV2: VersionedSchema {
    static let versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] { [Expense.self] }

    @Model
    final class Expense {
        var title: String
        var amountCents: Int
        var note: String?

        init(title: String, amountCents: Int) {
            self.title = title
            self.amountCents = amountCents
        }
    }
}

enum ExpenseMigration: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ExpensesV1.self, ExpensesV2.self]
    }

    static var stages: [MigrationStage] {
        [
            .lightweight(
                fromVersion: ExpensesV1.self,
                toVersion: ExpensesV2.self
            )
        ]
    }
}

struct ExpenseSnapshot {
    let title: String
    let amountCents: Int
    let note: String?
}

@MainActor
func saveVersionOne(at url: URL) throws {
    let schema = Schema(versionedSchema: ExpensesV1.self)
    let settings = ModelConfiguration(schema: schema, url: url)
    let container = try ModelContainer(for: schema, configurations: settings)
    let expense = ExpensesV1.Expense(title: "Caffè", amountCents: 250)
    container.mainContext.insert(expense)
    try container.mainContext.save()
}

@MainActor
func openVersionTwo(at url: URL) throws -> [ExpenseSnapshot] {
    let schema = Schema(versionedSchema: ExpensesV2.self)
    let settings = ModelConfiguration(schema: schema, url: url)
    let container = try ModelContainer(
        for: schema,
        migrationPlan: ExpenseMigration.self,
        configurations: settings
    )
    let context = container.mainContext
    let records = try context.fetch(FetchDescriptor<ExpensesV2.Expense>())
    return records.map {
        ExpenseSnapshot(
            title: $0.title, amountCents: $0.amountCents, note: $0.note
        )
    }
}

struct ContentView: View {
    @State private var message = "Pronti per la migrazione"

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
            Button("Prova migrazione") {
                migrate()
            }
        }
        .padding()
    }

    private func migrate() {
        let folder = UUID().uuidString
        let directory = URL.temporaryDirectory
            .appending(path: folder, directoryHint: .isDirectory)
        let url = directory.appending(path: "expenses.store")
        do {
            try FileManager.default.createDirectory(
                at: directory, withIntermediateDirectories: true
            )
            defer { try? FileManager.default.removeItem(at: directory) }
            try autoreleasepool { try saveVersionOne(at: url) }
            let migrated = try openVersionTwo(at: url)
            guard let expense = migrated.first else {
                message = "Nessun record recuperato"
                return
            }
            let note = expense.note ?? "nessuna nota"
            message = "\(expense.title) · \(expense.amountCents) · \(note)"
        } catch {
            message = "Migrazione non riuscita"
        }
    }
}

#Preview {
    ContentView()
}
