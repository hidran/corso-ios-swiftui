//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import SwiftData

@Model
final class Expense {
    var title: String
    var amountCents: Int
    var category: String

    init(title: String, amountCents: Int, category: String) {
        self.title = title
        self.amountCents = amountCents
        self.category = category
    }
}

@MainActor
enum SampleStore {
    static let container: ModelContainer? = {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        guard let container = try? ModelContainer(
            for: Expense.self, configurations: configuration
        ) else { return nil }
        let context = container.mainContext
        context.insert(Expense(title: "Pane", amountCents: 190, category: "Cibo"))
        context.insert(Expense(title: "Treno", amountCents: 1500, category: "Viaggi"))
        context.insert(Expense(title: "Spesa", amountCents: 950, category: "Cibo"))
        context.insert(Expense(title: "Bus", amountCents: 300, category: "Viaggi"))
        try? context.save()
        return container
    }()
}

#if compiler(>=6.4)
@available(iOS 27, *)
struct ExpenseSections: View {
    @Query(
        filter: #Predicate<Expense> { $0.amountCents >= 300 },
        sort: \Expense.amountCents, order: .reverse,
        sectionBy: \Expense.category
    )
    private var expenses: SectionedResults<Expense, String>

    var body: some View {
        List {
            ForEach(expenses) { section in
                Section(section.title) {
                    ForEach(section) { expense in
                        LabeledContent(expense.title, value: String(expense.amountCents))
                    }
                }
            }
        }
        .navigationTitle("Spese per categoria")
    }
}
#endif

struct ContentView: View {
    var body: some View {
        NavigationStack {
            if let container = SampleStore.container {
                Group {
#if compiler(>=6.4)
                    if #available(iOS 27, *) {
                        ExpenseSections()
                    } else {
                        ExpenseList()
                    }
#else
                    ExpenseList()
#endif
                }
                .modelContainer(container)
            } else {
                Text("Archivio non disponibile")
            }
        }
    }
}

struct ExpenseList: View {
    @Query(
        filter: #Predicate<Expense> { $0.amountCents >= 300 },
        sort: \Expense.amountCents, order: .reverse
    )
    private var expenses: [Expense]

    var body: some View {
        List(expenses) { expense in
            LabeledContent(expense.title, value: String(expense.amountCents))
        }
        .navigationTitle("Da 300 centesimi")
    }
}

#Preview {
    ContentView()
}
