# Lezione 35: mini app, Quiz a punti

Il progetto com'è alla fine della lezione.

L'app Quiz a punti: domande sulla pizza, tre risposte, dieci punti per ogni risposta giusta.

## Che cosa c'è dentro

- struct Question con static let samples
- enum Feedback con il messaggio calcolato
- struct Quiz con i metodi mutating answer(_:) e next()
- Una sola variabile @State e pulsanti che chiamano i metodi

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
