Kurzfassung zuerst:
**Du kannst KiCad‑Symbole in dein Haskell‑Cabal‑Projekt integrieren, indem du sie entweder (1) als externe Ressourcen einliest, (2) in dein eigenes SVG‑Rendering übersetzt oder (3) automatisch aus KiCad‑.kicad_sym Dateien generierst.**
Ich zeige dir alle drei Wege — modular, reproduzierbar und passend zu deiner TechDraw‑Architektur.

---

## 🔧 1. *Einfachster Weg:* KiCad‑SVG exportieren → als Ressource in Cabal einbinden

### Schritt 1 — In KiCad Symbol als SVG exportieren
In KiCad 7/8:

**Symbol Editor → Datei → Exportieren → SVG**

Du erhältst z. B.:

```
resources/kicad/CapacitorPolar.svg
```

### Schritt 2 — In Cabal als Datenressource einbinden

In deiner `*.cabal`:

```cabal
data-files:
    resources/kicad/*.svg
```

### Schritt 3 — In Haskell laden

```haskell
import Paths_TechDraw (getDataFileName)

loadSvg :: FilePath -> IO String
loadSvg name = do
  path <- getDataFileName ("resources/kicad/" ++ name)
  readFile path
```

### Schritt 4 — In dein Symbol‑Rendering integrieren

```haskell
renderKicadSymbol :: FilePath -> Point -> IO SVG
renderKicadSymbol file (x,y) = do
  raw <- loadSvg file
  pure (EmbedSvg raw (x,y))
```

Damit kannst du **jedes KiCad‑Symbol direkt in dein TechDraw‑SVG einbetten**.

---

## 🔧 2. *Sauberster Weg:* KiCad‑Symbol → Haskell‑SVG übersetzen

Du willst langfristig **IEC‑60617‑konforme Symbole in Haskell**, nicht fremde SVG‑Fragmente.
Dann ist der Workflow:

### Schritt 1 — KiCad‑Symbol als SVG exportieren
→ liefert dir die Geometrie.

### Schritt 2 — SVG‑Path in dein Haskell‑Path‑Modell übersetzen
Du hast bereits:

```haskell
data PathCommand
  = MoveTo Double Double
  | LineTo Double Double
  | ArcTo Double Double Double Bool Bool Double Double
  | ...
```

Du kannst also KiCad‑SVG‑Paths 1:1 nachbauen.

Beispiel: KiCad erzeugt oft:

```
M 0 0 A 10 10 0 0 1 20 0
```

In Haskell:

```haskell
renderCapacitorPolarFromKicad :: Point -> SVG
renderCapacitorPolarFromKicad (x,y) =
  Path
    [ MoveTo (x) (y)
    , ArcTo 10 10 0 False True (x+20) (y)
    ]
    stroke
```

Das ist **vollständig kompatibel mit deinem TechDraw‑SVG‑Renderer**.

---

## 🔧 3. *Automatischer Weg:* KiCad‑.kicad_sym → Haskell‑Code generieren

Die KiCad‑Symbolbibliothek liegt im Format:

```
*.kicad_sym
```

Das ist ein **S‑Expression‑Format**, z. B.:

```
(symbol CapacitorPolar
  (pin ...)
  (graphic (polyline ...))
)
```

Du kannst:

### Schritt 1 — Parser schreiben (Megaparsec oder Attoparsec)

### Schritt 2 — Geometrie extrahieren

### Schritt 3 — Automatisch Haskell‑Module generieren:

```
TechDraw/Electrical/Symbols/CapacitorPolar.hs
```

mit:

```haskell
renderCapacitorPolar :: Point -> SVG
renderCapacitorPolar (x,y) =
  Group
    [ Line ...
    , ArcTo ...
    ]
```

Damit hättest du:

- **vollautomatische Synchronisation** mit KiCad‑Bibliotheken
- **reproduzierbare Builds**
- **keine manuelle SVG‑Arbeit**

---

## 🧱 4. Cabal‑Integration (für alle drei Wege identisch)

In deiner `library`‑Sektion:

```cabal
exposed-modules:
    TechDraw.Electrical.Symbols.CapacitorPolar
    TechDraw.Electrical.Symbols.Resistors
    TechDraw.Electrical.Symbols.Capacitors
    ...
```

Wenn du SVG‑Ressourcen nutzt:

```cabal
data-files: resources/kicad/*.svg
```

Wenn du Generatoren nutzt:

```cabal
build-tools: kicad-symbol-gen
```

---

## 🎯 Empfehlung für dich (basierend auf deinem Projektstil)

Du arbeitest:

- modular
- reproduzierbar
- mit Test‑SVGs
- mit Cabal‑Automatisierung
- mit klaren Symbolfamilien

→ **Der beste Weg für dich ist: KiCad‑SVG exportieren → SVG‑Path in Haskell übersetzen.**

Warum:

- du behältst volle Kontrolle über Strichstärke, Normen, Skalierung
- du kannst Symbole exakt in dein TechDraw‑Koordinatensystem einpassen
- du kannst Test‑SVGs automatisch generieren
- du bleibst 100 % Haskell‑rein und reproduzierbar

---

## 👉 Nächster Schritt

Sag mir einfach:

**Welches KiCad‑Symbol willst du zuerst integrieren?**
(z. B. *CapacitorPolar*, *OpAmp*, *MOSFET*, *Ground*, *Connector*, …)

Dann baue ich dir:

- das **Haskell‑Modul**
- die **render‑Funktion**
- die **Cabal‑Einbindung**
- und auf Wunsch das **Test‑SVG**

Alles modular und exakt passend zu deiner bestehenden TechDraw‑Architektur.
