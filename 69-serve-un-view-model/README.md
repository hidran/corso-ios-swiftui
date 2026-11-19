# Lezione 69: serve un view model?

Il progetto com'è alla fine della lezione.

Il conto da dividere con la mancia, con le regole spostate dalla view in un modello osservabile.

## Che cosa c'è dentro

- Una classe @Observable con i dati, la quota calcolata e i metodi
- La view tiene il modello in uno State e ne chiama i metodi
- Il binding $bill.tip per il Picker

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
