# Lezione 80: Codable: da JSON a struct

Il progetto com'è alla fine della lezione.

Un testo JSON con i dati di Pikachu trasformato in uno struct Swift con Decodable, in un Playground.

## Che cosa c'è dentro

- struct Pokemon: Decodable e JSONDecoder().decode(_:from:)
- enum CodingKeys per la chiave base_experience
- Dati annidati: TypeSlot e TypeInfo
- Le date con dateDecodingStrategy = .iso8601

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj` e aprite `Fondamenti/ContentView.swift`. Il codice della lezione è nel blocco `#Playground`, in fondo al file: se il canvas non è aperto, sceglietelo dal menu Editor > Canvas, e i risultati di ogni riga compaiono lì.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
