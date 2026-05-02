Kurz und klar: **Ja, du kannst TechDraw so erweitern, dass es einen vollständigen Stromlaufplan‑Workflow unterstützt** – aber du musst TechDraw dafür **architektonisch erweitern**, nicht nur ein paar SVG‑Shapes hinzufügen.
Du arbeitest bereits mit einer modularen SVG‑Engine (Path, Render, SVGRender). Genau das ist die perfekte Basis für ein **elektrisches Symbol‑ und Verbindungs‑System**.

Ich gebe dir jetzt eine **präzise, modulare Architektur**, die zu deinem TechDraw‑Projekt passt und vollständig reproduzierbar ist.

---

## ⚡ Ziel: TechDraw → Stromlaufplan‑Engine
Ein Stromlaufplan braucht drei Dinge:

1. **Symbolbibliothek**
   Widerstand, Schalter, Sicherung, Relais, Klemme, Erdung, Motor, usw.

2. **Verbindungen (Wires)**
   Linien mit Snap‑Points, optional orthogonal, optional mit Knoten.

3. **Layout‑/Koordinatensystem**
   Raster, Snap, Layer, Gruppierung.

Du hast bereits:

- `SVG`
- `PathCommand`
- `renderSVG`
- `renderPathCommand`

Das ist die perfekte Grundlage.

---

# 🧱 1. Neue Modulstruktur (idiomatisch, TechDraw‑Style)

```
TechDraw/
  Electrical/
    Types.hs          -- SymbolType, Pin, Wire, Net
    Symbol.hs         -- konkrete Symbole als SVG
    Library.hs        -- Symbolbibliothek
    Render.hs         -- renderElectrical :: Electrical -> SVG
    Layout.hs         -- Raster, Snap, Positionierung
  SVG/
    Path/
      Types.hs
      Tokenizer.hs
      Parser.hs
      Render.hs
    Types.hs
    Render.hs
    SVGRender.hs
```

Damit bleibt dein SVG‑Core **sauber**, und die Elektrotechnik‑Logik sitzt in einem eigenen Namespace.

---

# 🔌 2. Electrical.Types – zentrale Datentypen

```haskell
module TechDraw.Electrical.Types where

import TechDraw.SVG

data Pin = Pin
  { pinName :: String
  , pinPos  :: Point
  }

data SymbolType
  = Resistor
  | Capacitor
  | Inductor
  | Switch
  | Fuse
  | Ground
  | Motor
  | Lamp
  deriving (Eq, Show)

data Symbol = Symbol
  { symType :: SymbolType
  , symPos  :: Point
  , symRot  :: Double
  }

data Wire = Wire
  { wirePoints :: [Point]
  }

data Electrical = Electrical
  { symbols :: [Symbol]
  , wires   :: [Wire]
  }
```

Das ist minimal, aber **erweiterbar**.

---

# 🎨 3. Electrical.Symbol – Symbole als SVG erzeugen

Beispiel: Widerstand (IEC‑Symbol)

```haskell
renderResistor :: Point -> Double -> SVG
renderResistor (x,y) rot =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Rect (x+10, y-3) (20,6) (Just (StrokeColor "black" 1)) (FillNone)
    , Line (x+30, y) (x+40, y) (Just (StrokeColor "black" 1))
    ]
```

Beispiel: Erdung

```haskell
renderGround :: Point -> SVG
renderGround (x,y) =
  Group
    [ Line (x, y) (x, y+5) (Just (StrokeColor "black" 1))
    , Line (x-5, y+5) (x+5, y+5) (Just (StrokeColor "black" 1))
    , Line (x-3, y+7) (x+3, y+7) (Just (StrokeColor "black" 1))
    ]
```

---

# 🧩 4. Electrical.Render – gesamtes Schaltbild rendern

```haskell
renderElectrical :: Electrical -> SVG
renderElectrical (Electrical syms wires) =
  Group (map renderSymbol syms ++ map renderWire wires)

renderSymbol :: Symbol -> SVG
renderSymbol (Symbol t pos rot) = case t of
  Resistor -> renderResistor pos rot
  Ground   -> renderGround pos
  Switch   -> renderSwitch pos rot
  Fuse     -> renderFuse pos rot
  _        -> Group []  -- Platzhalter

renderWire :: Wire -> SVG
renderWire (Wire pts) =
  Polyline pts (Just (StrokeColor "black" 1))
```

Damit kannst du **komplette Stromlaufpläne** erzeugen.

---

# 📐 5. Electrical.Layout – Raster & Snap

```haskell
snapToGrid :: Double -> Point -> Point
snapToGrid g (x,y) =
  (fromIntegral (round (x/g)) * g,
   fromIntegral (round (y/g)) * g)
```

Optional:

- orthogonale Leitungen
- automatische Knotenpunkte
- Net‑Labels

---

# 🧭 6. Beispiel: kompletter Stromlaufplan

```haskell
scene :: Electrical
scene = Electrical
  { symbols =
      [ Symbol Resistor (100,100) 0
      , Symbol Ground   (100,150) 0
      ]
  , wires =
      [ Wire [(100,100),(100,150)]
      ]
  }
```

Dann:

```haskell
renderSvgDoc (renderElectrical scene)
```

---

# 🎯 Was du jetzt bekommst

Ich kann dir sofort liefern:

### ✔ komplette Modulstruktur
### ✔ alle Symbole (IEC‑konform)
### ✔ Wire‑Routing (orthogonal)
### ✔ Snap‑System
### ✔ Layer‑System (z. B. „Symbols“, „Wires“, „Labels“)
### ✔ PlantUML‑Diagramm der Architektur
### ✔ Beispiel‑Schaltplan (SVG)

---

# Willst du als Nächstes:

1. **die komplette Symbolbibliothek (IEC 60617)**
2. **die fertigen Haskell‑Module**
3. **ein PlantUML‑Diagramm der Electrical‑Architektur**
4. **ein vollständiges Beispielprojekt (TechDraw‑Electrical)**

Sag mir einfach, welchen Teil du zuerst willst.
