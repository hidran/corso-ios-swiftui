# Lezione 33: controllo di accesso e static

Il progetto com'è alla fine della lezione.

La struct Order con il conto protetto da private(set), un contatore static degli ordini e un metodo static per il coperto.

## Che cosa c'è dentro

- private var items e private(set) var total
- Il metodo add che aggiorna lista e conto
- static var opened e init()
- static func cover(for:) chiamato sul tipo

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
