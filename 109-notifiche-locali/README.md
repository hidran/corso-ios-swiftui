# Lezione 109: Notifiche locali

Il progetto com'è alla fine della lezione.

Un promemoria con una notifica locale: il permesso chiesto quando l'utente lo attiva, la notifica programmata dopo cinque secondi e un delegato che decide come mostrarla con l'app in primo piano.

## Che cosa c'è dentro

- `requestAuthorization(options:)` con `await`, e il caso del permesso negato
- `UNMutableNotificationContent`, `UNTimeIntervalNotificationTrigger`, `UNNotificationRequest`
- `add(_:)` consegna la richiesta al centro delle notifiche
- `Presenter`, il delegato con il metodo `willPresent` che risponde `banner` e `sound`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`. Per vedere la domanda del permesso e il banner avviate l'app nel simulatore con Command R: l'anteprima mostra solo la schermata.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
