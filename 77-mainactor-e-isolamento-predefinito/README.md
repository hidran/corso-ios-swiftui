# Lezione 77: MainActor e isolamento predefinito

Il progetto com'è alla fine della lezione.

Un calcolo pesante: prima blocca l'interfaccia, perché tutto il progetto sta sull'attore principale; poi, con `@concurrent`, gira fuori, e torna sull'attore principale con `await` solo per mostrare il risultato.

## Che cosa c'è dentro

- L'isolamento predefinito del progetto: tutto sul `MainActor`
- `@concurrent func countMultiples(upTo:) async`: il lavoro pesante fuori dall'attore principale
- `await showResult(count)`: tornare sull'attore principale
- Il progetto usa la modalità Swift 5: i controlli di isolamento sono avvisi, con Swift 6 diventano errori

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
