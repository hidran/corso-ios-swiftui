# Lezione 83: AsyncImage e cache

Il progetto com'è alla fine della lezione.

Una lista di Pokémon con le loro immagini scaricate da AsyncImage, le fasi del caricamento e, da iOS 27, una cache tutta nostra.

## Che cosa c'è dentro

- AsyncImage(url:) e la closure con le fasi
- Un simbolo quando l'immagine non esiste
- Novità iOS 27: asyncImageURLSession con una URLSession e una URLCache
- Un pulsante che legge quanto tiene la cache

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
