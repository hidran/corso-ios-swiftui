# Lezione 78: Lavori in parallelo

Il progetto com'è alla fine della lezione.

Tre, poi cinque Pokémon che arrivano in due secondi ciascuno: uno dopo l'altro servono sei secondi, in parallelo ne bastano due.

## Che cosa c'è dentro

- Il tempo misurato con `ContinuousClock.now`
- `async let` per un numero fisso di lavori, e un solo `await` per i risultati
- `withTaskGroup`, `addTask` e `for await` per una lista di qualunque lunghezza

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
