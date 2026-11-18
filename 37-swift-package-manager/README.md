# Lezione 37: Swift Package Manager

Il progetto com'è alla fine della lezione.

Il progetto con il pacchetto ConfettiSwiftUI: un pulsante Festeggia che fa piovere pizze.

## Che cosa c'è dentro

- La dipendenza ConfettiSwiftUI, regola Up to Next Major Version da 3.0.0
- import ConfettiSwiftUI
- @State private var party e il modificatore .confettiCannon(trigger: $party)
- confettis: [.text("🍕")]

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`: alla prima apertura Xcode scarica il pacchetto ConfettiSwiftUI da GitHub (serve la connessione). Il codice della lezione è in `Fondamenti/ContentView.swift`, e nell'anteprima il pulsante Festeggia fa partire i coriandoli.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
