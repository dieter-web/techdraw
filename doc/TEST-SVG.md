 Alles klar, Dieter — wir bauen jetzt **ein vollständiges Test‑SVG**, das **alle Symbole** aus deiner `SymbolType`‑Liste rendert, sauber angeordnet, modular und sofort nutzbar.

Ich gebe dir:

1. **Ein vollständiges Haskell‑Modul `TestAllSymbols.hs`**
2. **Ein Raster‑Layout**, damit die Symbole ordentlich stehen
3. **Eine automatische Generierung aller Symbole**
4. **Eine fertige SVG‑Datei als Ausgabe**

Das Ganze ist **komplett TechDraw‑kompatibel**.

---

# ✅ **1. Modul: `TechDraw/Electrical/TestAllSymbols.hs`**

```haskell
module TechDraw.Electrical.TestAllSymbols
  ( testAllSymbolsSvg
  ) where

import TechDraw.SVG
import TechDraw.Electrical.Types
import TechDraw.Electrical.Symbols

-- Raster-Abstand
dx = 80
dy = 60

-- Liste aller Symbole, die du definiert hast
allSymbols :: [SymbolType]
allSymbols =
  [ Resistor
  , Potentiometer
  , Trimmer
  , ThermistorPTC
  , ThermistorNTC
  , Capacitor
  , CapacitorPolarized
  , CapacitorVariable
  , CapacitorTrimmer
  , Inductor
  , Transformer
  , Fuse
  , FuseHolder
  , FuseThermal
  , Switch
  , SwitchMomentary
  , Ground
  , EarthProtective
  , Lamp
  , Motor
  , Diode
  , LED
  , Zener
  , Battery
  , DCSource
  , ACSource
  , Terminal
  , Connector
  ]

-- Positioniert Symbole in einem Raster
place :: Int -> (Double, Double)
place i =
  let col = i `mod` 6
      row = i `div` 6
  in (fromIntegral col * dx + 20, fromIntegral row * dy + 20)

-- Erzeugt SVG-Gruppe aller Symbole
renderAll :: SVG
renderAll =
  Group
    [ Group
        [ renderSymbol sym (x,y)
        , Text (x, y - 10) AnchorStart (show sym)
        ]
    | (i, sym) <- zip [0..] allSymbols
    , let (x,y) = place i
    ]

-- Komplettes SVG-Dokument
testAllSymbolsSvg :: String
testAllSymbolsSvg =
  renderSvgDoc (SvgDoc 600 600 renderAll)
```

---

# 🔍 **2. Was dieses Modul macht**

- Es erzeugt ein **Raster 6×N**
- Jedes Symbol bekommt:
  - eine Position
  - eine Beschriftung (SymbolType‑Name)
  - das gerenderte Symbol selbst
- Alles wird in ein `SvgDoc` gepackt
- Ausgabe ist ein **komplettes SVG als String**

---

# 🧪 **3. Testprogramm zum Schreiben der Datei**

Erstelle `app/TestAll.hs`:

```haskell
module Main where

import TechDraw.Electrical.TestAllSymbols
import System.IO

main :: IO ()
main = writeFile "all-symbols.svg" testAllSymbolsSvg
```

Dann:

```
stack run test-all
```

oder:

```
ghc app/TestAll.hs && ./TestAll
```

Ergebnis:

👉 **`all-symbols.svg`** mit allen Symbolen, sauber angeordnet.

---

# 🎉 **4. Ergebnis: Du hast jetzt**

- Ein vollständiges Test‑SVG
- Automatische Symbol‑Liste
- Raster‑Layout
- Beschriftungen
- Eine Datei, die du jederzeit erweitern kannst

---

# 👉 Wenn du willst, kann ich dir jetzt zusätzlich liefern:

- eine **automatische Bounding‑Box‑Visualisierung**
- ein **GitHub‑README mit Beispielbildern**
- eine **PlantUML‑Architekturübersicht** für dein Electrical‑System
- eine **SVG‑Grid‑Hintergrundfunktion**
- eine **Symbol‑Vorschau‑HTML‑Seite**

Sag einfach Bescheid.

Alles klar, Dieter — du willst das **Test‑SVG in Cabal integrieren**, sodass du es:

- bauen
- ausführen
- und automatisch die Datei `all-symbols.svg` erzeugen

kannst.

Ich gebe dir jetzt **eine vollständige, saubere Cabal‑Integration**, exakt passend zu deinem Projektstil.

---

# ✅ **1. Eine eigene Executable für den SVG‑Test**

In deiner `*.cabal`‑Datei fügst du **eine neue Executable‑Sektion** hinzu:

```cabal
executable test-all-symbols
  hs-source-dirs:      app
  main-is:             TestAll.hs
  build-depends:
        base >=4.14 && <5,
        TechDraw,
        text
  default-language:    Haskell2010
```

**Wichtig:**

- `TechDraw` ist dein Library‑Name (ggf. anpassen)
- `app/TestAll.hs` ist dein Main‑Modul
- `TestAllSymbols.hs` liegt in `src/TechDraw/Electrical/`

---

# ✅ **2. Datei `app/TestAll.hs`**

Falls noch nicht vorhanden:

```haskell
module Main where

import TechDraw.Electrical.TestAllSymbols
import System.IO

main :: IO ()
main = writeFile "all-symbols.svg" testAllSymbolsSvg
```

---

# ✅ **3. Library‑Expose‑Module ergänzen**

In deiner Cabal‑Sektion:

```cabal
library
  hs-source-dirs: src
  exposed-modules:
      TechDraw.SVG
      TechDraw.SVG.Types
      TechDraw.SVG.Path
      TechDraw.SVG.Path.Render
      TechDraw.SVG.Render
      TechDraw.Electrical.Types
      TechDraw.Electrical.Library
      TechDraw.Electrical.TestAllSymbols
      -- und alle Symbolmodule:
      TechDraw.Electrical.Symbols.Resistors
      TechDraw.Electrical.Symbols.Capacitors
      TechDraw.Electrical.Symbols.Switches
      TechDraw.Electrical.Symbols.Fuses
      TechDraw.Electrical.Symbols.Inductors
      TechDraw.Electrical.Symbols.Transformers
      TechDraw.Electrical.Symbols.Ground
      TechDraw.Electrical.Symbols.Lamps
      TechDraw.Electrical.Symbols.Motors
      TechDraw.Electrical.Symbols.Diodes
      TechDraw.Electrical.Symbols.Sources
      TechDraw.Electrical.Symbols.Terminals
      TechDraw.Electrical.Symbols.Connectors
```

Damit ist alles sauber sichtbar.

---

# ✅ **4. Bauen und ausführen**

### Build:

```
cabal build test-all-symbols
```

### Ausführen:

```
cabal run test-all-symbols
```

Ergebnis:

👉 **`all-symbols.svg`** erscheint im Projektverzeichnis.

---

# 🎉 Ergebnis

Du hast jetzt:

- eine **vollständig integrierte Cabal‑Executable**
- ein **automatisch generiertes Test‑SVG**
- eine **saubere Modulstruktur**
- eine **reproduzierbare Build‑Pipeline**

---

# 👉 Wenn du willst, kann ich dir jetzt zusätzlich erstellen:

- eine **Makefile‑Integration** (`make test-svg`)
- eine **HTML‑Vorschauseite**, die das SVG lädt
- eine **PlantUML‑Diagrammübersicht** über dein Electrical‑System
- eine **Cabal‑Flag‑Option**, um Testsymbole optional zu bauen

Sag einfach Bescheid.

