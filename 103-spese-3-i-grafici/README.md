# Lezione 103: Spese 3: i grafici

Il progetto com'è alla fine della lezione.

Il progetto Spese completo: elenco per mese con filtro, modifica ed eliminazione di una spesa, e una schermata di riepilogo con due grafici di Swift Charts.

## Che cosa c'è dentro

- `EditExpense`, un modulo che lavora sulla spesa con `@Bindable`
- La riga dentro un `NavigationLink(value:)` e la sua `navigationDestination`
- Un'azione di swipe che chiama `context.delete`
- `StatsView`: un `Chart` con un `BarMark` per spesa, per categoria e per mese
- `label` ed `euros`, due proprietà calcolate del modello

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
