# Lezione 71: Ciclo di vita dell'app

Il progetto com'è alla fine della lezione.

Una schermata che segue il ciclo di vita della sua scena: la fase attuale, i ritorni dal background e la cronologia delle fasi.

## Che cosa c'è dentro

- FondamentiApp.swift: @main, App, Scene e WindowGroup
- @Environment(\.scenePhase): attiva, inattiva, in background
- onChange(of:) con il valore vecchio e quello nuovo

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`. Le fasi si vedono nel simulatore: avviate l'app con Command R, tornate alla Home con Maiuscole Command H e toccate l'icona di Fondamenti per rientrare.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
