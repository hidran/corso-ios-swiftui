# Lezione 79: Actor e Sendable in parole semplici

Il progetto com'è alla fine della lezione.

Un box di Pokémon condiviso da cento compiti in parallelo: un actor protegge i suoi dati, e da fuori ci si entra con await.

## Che cosa c'è dentro

- `actor PokemonBox` con un array privato, `add(_:)` e `count`
- Cento compiti figli in un `withTaskGroup`, ognuno con `await box.add(...)`
- `let total = await box.count`: anche per leggere si aspetta il proprio turno

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
