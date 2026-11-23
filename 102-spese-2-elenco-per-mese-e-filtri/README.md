# Lezione 102: Spese 2: elenco per mese e filtri

Il progetto com'è alla fine della lezione.

La seconda parte del progetto Spese: l'elenco diviso per mese, con gli importi in euro, spese di esempio per l'anteprima e un filtro per categoria.

## Che cosa c'è dentro

- `seed`, le spese di esempio, chiamata dalla closure `onSetup` di `modelContainer`
- `price` e `month`, due proprietà calcolate del modello
- `MonthSection`, una sezione per ogni mese
- `ExpenseList` costruisce la sua `Query` nell'init, con `#Predicate` e l'ordinamento per data
- Un `Picker` segmentato in fondo alla schermata sceglie la categoria

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
