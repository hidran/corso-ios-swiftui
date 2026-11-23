# Lezione 105: Mappe in SwiftUI

Il progetto com'è alla fine della lezione.

Una mappa di Roma con tre monumenti, un'annotazione disegnata in SwiftUI e due pulsanti che muovono la camera.

## Che cosa c'è dentro

- `Map` di MapKit, con il contenuto tra le graffe
- `Marker` con titolo, coordinata e `tint`, creati con `ForEach` da un array di `Place`
- `Annotation`: una vista SwiftUI ancorata a una coordinata
- `MapCameraPosition` in uno `@State` legato alla mappa: `.automatic` e `.region(MKCoordinateRegion(center:latitudinalMeters:longitudinalMeters:))`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: la mappa compare nell'anteprima accanto al codice (serve la rete), e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
