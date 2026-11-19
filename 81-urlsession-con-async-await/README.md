# Lezione 81: URLSession con async/await

Il progetto com'è alla fine della lezione.

La lista dei primi cinque Pokémon scaricata da PokéAPI con URLSession e async/await, con il controllo del codice di stato.

## Che cosa c'è dentro

- PokemonPage e PokemonEntry: Decodable
- fetchPokemon(): try await URLSession.shared.data(from:)
- La lista caricata con .task
- Il codice di stato con HTTPURLResponse e un errore LoadError

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
