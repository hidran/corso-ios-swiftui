# Lezione 104: Permessi e privacy

Il progetto com'è alla fine della lezione.

Una schermata che cerca i negozi vicini chiede il permesso di usare la posizione nel modo giusto: una frase che spiega il perché, la richiesta quando si tocca il pulsante, e un collegamento alle Impostazioni se la risposta è no.

## Che cosa c'è dentro

- La chiave `Privacy - Location When In Use Usage Description` (`NSLocationWhenInUseUsageDescription`) nelle Info del target: nel progetto è l'impostazione `INFOPLIST_KEY_NSLocationWhenInUseUsageDescription`
- `CLServiceSession(authorization: .whenInUse)`: la richiesta parte quando si tocca il pulsante
- `session.diagnostics` con `for try await`: `authorizationRequestInProgress` e `authorizationDenied`
- Il caso del no: un messaggio e un `Link` a `UIApplication.openSettingsURLString`
- Per riprovare da capo nel simulatore: `xcrun simctl privacy booted reset location com.hidrasoft.Fondamenti`, oppure eliminate l'app dal simulatore

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`. L'avviso del permesso non compare nell'anteprima: avviate l'app nel simulatore con Command R. Se nelle Info del target (scheda Info) non trovate la chiave `Privacy - Location When In Use Usage Description`, aggiungetela come nella lezione: senza, la richiesta fallisce.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
