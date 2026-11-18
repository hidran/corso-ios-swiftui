# Lezione 34: errori, throws, do, try e catch

Il progetto com'è alla fine della lezione.

L'enum OrderError, la funzione price(of:) che lancia errori, e i modi per gestirli: try?, do e catch, typed throws e Result.

## Che cosa c'è dentro

- enum OrderError: Error con due casi
- func price(of:) throws(OrderError) -> Double
- try?, do e catch con un pattern
- do throws(OrderError) e uno switch senza default
- Result { try ... } letto con uno switch

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
