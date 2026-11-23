# Lezione 107: Tocchi sulla mappa e ricerca di luoghi

Il progetto com'è alla fine della lezione.

Una mappa che risponde: toccate un punto per sapere l'indirizzo, poi cercate le gelaterie lì attorno.

## Che cosa c'è dentro

- `MapReader` e `onTapGesture`: `proxy.convert(point, from: .local)` trasforma il tocco in una coordinata
- `MKReverseGeocodingRequest` (iOS 26): dalla coordinata ai `mapItems`, e da lì `address?.shortAddress`
- `MKLocalSearch` con `naturalLanguageQuery`, una `region` attorno al punto toccato e `regionPriority = .required`, che tiene i risultati dentro la zona
- `Marker(item:)` per mostrare i risultati della ricerca
- Indirizzi e risultati arrivano dai servizi di Apple: serve la rete, non servono chiavi né account

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: la mappa compare nell'anteprima accanto al codice (serve la rete), e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
