# Lezione 110: Grafici con Swift Charts

Il progetto com'è alla fine della lezione.

Le temperature medie di un anno in un solo grafico di Swift Charts: linea, punti, area, la riga della media, scala e assi scelti da noi e un asse x che scorre.

## Che cosa c'è dentro

- `LineMark` con `interpolationMethod(.catmullRom)`, `PointMark` e `AreaMark` nello stesso `ForEach`
- `RuleMark` con `annotation` per la media
- `chartYScale(domain:)`, `chartYAxis` con `AxisMarks(position: .leading)`, `chartYAxisLabel`
- `chartScrollableAxes(.horizontal)` e `chartXVisibleDomain(length: 6)`

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
