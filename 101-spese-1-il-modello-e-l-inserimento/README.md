# Lezione 101: Spese 1: il modello e l'inserimento

Il progetto com'è alla fine della lezione.

La prima parte del progetto Spese: il modello SwiftData di una spesa, il contenitore per l'app e quello in memoria per l'anteprima, e un modulo che inserisce una spesa nuova.

## Che cosa c'è dentro

- `Expense`, una classe `@Model` con titolo, centesimi, categoria e data
- `ContentView` collega il contenitore su disco, l'anteprima ne usa uno in memoria
- `ExpenseList` legge le spese con `@Query`
- `AddExpense`, un modulo in un foglio: converte l'importo in centesimi e chiama `insert`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
