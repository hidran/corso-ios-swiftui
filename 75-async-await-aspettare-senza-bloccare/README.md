# Lezione 75: async/await: aspettare senza bloccare

Il progetto com'è alla fine della lezione.

Una prima funzione asincrona: la squadra arriva dopo due secondi di attesa, e intanto una rotella mostra che l'app sta lavorando.

## Che cosa c'è dentro

- `func loadTeam() async -> [String]` con `try? await Task.sleep(for: .seconds(2))`
- Il pulsante Carica chiama la funzione dentro un `Task`
- Lo stato `isLoading` e una `ProgressView` in un `overlay`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
