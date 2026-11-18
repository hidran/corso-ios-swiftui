# Lezione 36: property wrapper e macro, i simboli @ e #

Il progetto com'è alla fine della lezione.

Un property wrapper tutto nostro, UpToFive, usato in una recensione; @State, @Observable e #fileID letti come property wrapper e macro.

## Che cosa c'è dentro

- @propertyWrapper struct UpToFive con wrappedValue e didSet
- struct Review con @UpToFive var stars
- @State in ContentView
- @Observable class Oven
- let file = #fileID

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
