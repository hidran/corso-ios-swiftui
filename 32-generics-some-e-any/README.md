# Lezione 32: generics, some e any

Il progetto com'è alla fine della lezione.

Una funzione generica, il tipo generico Queue, e il protocollo Priced usato con some e con any.

## Che cosa c'è dentro

- func largest<T: Comparable>
- struct Queue<Item> e Queue<String>()
- withCover(_ item: some Priced)
- Un array [any Priced] con una pizza e una bibita

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
