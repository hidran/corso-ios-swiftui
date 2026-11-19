# Lezione 67: @Bindable ed @Environment

Il progetto com'è alla fine della lezione.

Un viaggio a Roma: i luoghi si spuntano con un Toggle collegato al modello, e un riepilogo in un foglio legge lo stesso modello dall'ambiente.

## Che cosa c'è dentro

- @Bindable per il binding a visited
- .environment(trip) in cima alle view
- @Environment(Trip.self) nella view del riepilogo

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
