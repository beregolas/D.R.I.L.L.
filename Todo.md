
### Aufgaben:

- Kollabohrertief (Feature 5.2)
  - Lokal multiplayer (Email an Wolfgang Brabänder ob das dann noch ein "One button game" ist wenn man einen zweiten Button )
  - Wenn ein Spieler das Ziel erreicht gewinnen beide
  - Wenn ein Spieler stirbt, verlieren beide
  - Spieler dürfen nicht kollidieren?


- Fortschrittsmechanik (Entfernung zum Ende und zum nächsten Meilenstein)
- Zarks Muckerburgs auftritte:
  - Bohrer geht Senkrecht, Zark wird groß eingeblendet
  - Bild anzeigen
  - Text anzeigen / audio abspielen automatisch ein und ausblenden
  - mindestens 3 Meilensteine
- Highscores im Hauptmenü anzeigen


- **Link zum Spielbaren Spiel in die Dokumentation**
- 1 Woche vor Abgabe Treffen für Dokumentation checken
- Check ob alles aus dem Aufgabenblatt abgedeckt (oder im Devlog vorhanden) ist


#### Felix:
- Menü
  - "Starten"
  - (Highscore der irgendwie ansteuerbar ist)
- Overlay  
  - Platz für Zark Muckerburg lassen (falls möglich)


#### Vincent:
  - Hindernisse dynamisch erscheinen lassen
  - auch dynamisch despawnen wenn sie aus der Kamera weg sind
  - Hindernis Ideen:
    - Steine?
    - Orange eingefärbte Kreise (= Magma)
    - Würmer, gerader Pfad (wie im Beispielspiel) und der Sprite macht eine schlängelnde Bewegung
    - Türme die einen (mit einem Projektil) abschießen (zur verteidigung des Erdkerns)
    - Bomben oder irgendwas explosives


#### Julius
  - Bohrerwarping mit fixierter Kamera
    - "Warping" heißt wenn der Bohrer links das Bild verlässt kommt er rechts wieder rein (und andersrum)
  - Funktioniert der neue Branch?
  - Erdschichten spawnen lassen
    - müssen auch wieder despawnen wenn sie den Bildschirm verlassen
    - es genügt wenn sie Stück für Stück auf (255, 0, 0) zugehen
