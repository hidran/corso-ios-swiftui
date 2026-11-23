# Lezione 106: La posizione dell'utente

Il progetto com'è alla fine della lezione.

Una mappa che segue la posizione dell'utente in diretta, con le coordinate scritte sotto e il punto blu al centro.

## Che cosa c'è dentro

- `CLLocationUpdate.liveUpdates()` letto con `for try await`: cominciare il ciclo fa comparire la richiesta del permesso
- `update.location` (opzionale) e `update.authorizationDenied`
- `task(id:)` avvia il ciclo quando si tocca il pulsante e lo cancella quando si tocca Ferma
- `UserAnnotation()` e `MapCameraPosition.userLocation(fallback:)`
- Nelle Info del target serve la chiave `Privacy - Location When In Use Usage Description`
- Nel simulatore: `xcrun simctl location booted set 41.8902,12.4922` imposta la posizione, `xcrun simctl location booted start --speed=30 41.8902,12.4922 41.8986,12.4769` simula uno spostamento, `xcrun simctl location booted clear` la toglie

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`. La posizione non c'è nell'anteprima: avviate l'app nel simulatore con Command R e impostate una posizione con i comandi qui sopra. Se nelle Info del target (scheda Info) non trovate la chiave `Privacy - Location When In Use Usage Description`, aggiungetela come nella lezione Permessi e privacy: senza, la richiesta del permesso fallisce.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
