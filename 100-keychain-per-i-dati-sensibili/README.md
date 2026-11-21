# Lezione 100: Keychain per i dati sensibili

Il progetto com'è alla fine della lezione.

Proviamo il Keychain con un valore inventato.

## Che cosa c'è dentro

- Una voce del portachiavi riconosciuta da classe, servizio e account
- `SecItemAdd` per salvarla, con il controllo del codice `OSStatus`
- `SecItemCopyMatching` per sapere se la voce esiste, senza leggere il segreto
- Un pulsante di prova che usa solo un valore inventato e rimuove la voce alla fine

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
