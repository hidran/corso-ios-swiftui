# Lezione 82: Stati di caricamento ed errori

Il progetto com'è alla fine della lezione.

La lista dei Pokémon con tre stati: caricamento, dati ed errore, con un pulsante Riprova.

## Che cosa c'è dentro

- enum LoadState con loading, loaded e failed
- load(): lo stato passa da un caso all'altro
- Una proprietà @ViewBuilder con uno switch
- ContentUnavailableView con descrizione e Riprova

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
