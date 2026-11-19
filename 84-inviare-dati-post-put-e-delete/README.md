# Lezione 84: Inviare dati: POST, PUT e DELETE

Il progetto com'è alla fine della lezione.

Tre pulsanti che inviano richieste POST, PUT e DELETE a JSONPlaceholder, un servizio di prova, e mostrano il codice di stato della risposta.

## Che cosa c'è dentro

- makeRequest: URLRequest con httpMethod e Content-Type
- send: URLSession.shared.data(for:), statusCode e una risposta decodificata
- POST con un corpo creato da JSONEncoder: 201 e il nuovo id
- PUT per sostituire, DELETE per eliminare

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
