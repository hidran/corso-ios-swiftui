# Lezione 76: Task, .task e cancellazione

Il progetto com'è alla fine della lezione.

Un uovo di Pokémon che si schiude dopo un conto alla rovescia: il lavoro parte con il modificatore task, oppure con il pulsante Avvia, e il pulsante Ferma lo cancella.

## Che cosa c'è dentro

- `func hatch() async` con `Task.sleep` dentro `do` e `catch`
- `.task { await hatch() }`: il lavoro vive quanto la view
- `@State private var job: Task<Void, Never>?` e `job?.cancel()`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
