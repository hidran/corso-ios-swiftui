# Lezione 74: Abitudini: completare, aggiungere, riepilogo del giorno

Il progetto com'è alla fine della lezione.

Il progetto Abitudini completo: abitudini da segnare come fatte, il riepilogo del giorno, l'impostazione per nascondere le fatte e un foglio per aggiungerne di nuove.

## Che cosa c'è dentro

- HabitRow con @Bindable e un Toggle a forma di bottone
- Proprietà calcolate nello store e il sottotitolo della lista
- @AppStorage per nascondere le abitudini fatte
- AddHabit: un foglio che legge lo store dall'ambiente

## Come aprirlo

Fate doppio clic su `Fondamenti.xcodeproj`. Il codice è in `Fondamenti/ContentView.swift`: l'anteprima compare accanto al codice, e con Command R l'app parte nel simulatore. Le abitudini fatte si perdono quando l'app si ferma; l'impostazione Solo da fare resta.

Il progetto è creato con Xcode 27.2, la versione usata nel corso.
