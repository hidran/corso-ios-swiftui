# Lezione 18: mini app, Dividi il conto

Il progetto com'è alla fine della lezione.

L'app Dividi il conto: il totale, le persone e la mancia si cambiano con i pulsanti, e l'app calcola quanto paga ciascuno.

## Che cosa c'è dentro

- Tre variabili @State: total (Double), people e tip (Int)
- Il calcolo all'inizio di body, con le conversioni Double(_:)
- Il risultato in euro con Text(_:format:) e .currency(code:)
- Pulsanti in HStack, con un if nell'azione

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
