# Lezione 23: closure che catturano valori

Il progetto com'è alla fine della lezione.

Le closure che catturano valori nel blocco #Playground: una funzione che restituisce una funzione, una funzione annidata, e un contatore.

## Che cosa c'è dentro

- discount(percent:) restituisce una funzione (Double) -> Double
- La funzione annidata apply cattura percent
- makeCounter() restituisce una closure che cattura e cambia count
- Due contatori, ognuno con la sua memoria

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
