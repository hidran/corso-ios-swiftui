# Lezione 108: Foto e fotocamera

Il progetto com'è alla fine della lezione.

Una schermata che fa scegliere una foto dalla libreria e la mostra, senza chiedere nessun permesso, e un pulsante per lo scatto che si spegne dove la fotocamera non c'è.

## Che cosa c'è dentro

- `PhotosPicker("Scegli una foto", selection: $selection, matching: .images)`: il selettore di sistema
- `PhotosPickerItem`: un segnaposto, i dati si caricano con `loadTransferable(type: Data.self)`
- `.task(id: selection)`: il caricamento riparte quando la scelta cambia
- `UIImage(data:)` e `Image(uiImage:)` per mostrare la foto
- `UIImagePickerController.isCameraDeviceAvailable(.rear)`: nel simulatore la fotocamera posteriore non c'è
- Per aggiungere foto al simulatore: `xcrun simctl addmedia booted foto.jpg`, oppure trascinate un'immagine sulla finestra del simulatore

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice della lezione è in `Fondamenti/ContentView.swift`. Per provare il selettore avviate l'app nel simulatore con Command R: la libreria del simulatore ha già alcune foto di esempio.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
