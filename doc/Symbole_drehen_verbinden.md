Alles klar, Dieter — **jetzt machen wir deine Symbole wirklich TechDraw‑tauglich**:

1. **Jedes Symbol wird drehbar** (Rotation um seinen Mittelpunkt oder um `symPos`)
2. **Symbole können über definierte Ports/Anschlusspunkte verbunden werden**
   → damit kannst du später Drähte automatisch an die richtigen Stellen snappen lassen.

Ich arbeite das **systematisch, modular und reproduzierbar** ab — so wie du es bevorzugst.

---

# ⭐ 1. Rotation für alle Symbole (SVG‑Transform)

Du hast aktuell:

```haskell
renderSymbol :: SymbolType -> Point -> SVG
```

Du brauchst:

```haskell
renderSymbolRot :: SymbolType -> Point -> Double -> SVG
```

Oder du nutzt deine bestehende `Symbol`‑Struktur:

```haskell
data Symbol = Symbol
  { symType :: SymbolType
  , symPos  :: Point
  , symRot  :: Double
  }
```

Dann definieren wir:

```haskell
renderSymbol :: Symbol -> SVG
renderSymbol (Symbol t pos rot) =
  Transform (Rotate rot pos) (renderSymbolBase t pos)
```

### 🔧 Dafür brauchst du zwei Dinge:

### **A) Eine Transform‑API**

In `TechDraw.SVG`:

```haskell
data Transform
  = Rotate Double Point
  | Translate Double Double
  | Scale Double Double

data SVG
  = Line Point Point (Maybe Stroke)
  | Polyline [Point] (Maybe Stroke)
  | Circle Point Double (Maybe Stroke)
  | Rect Point (Double, Double) (Maybe Stroke) Fill
  | Group [SVG]
  | Transform Transform SVG
```

### **B) Eine Basis‑Renderfunktion ohne Rotation**

```haskell
renderSymbolBase :: SymbolType -> Point -> SVG
renderSymbolBase = ...  -- dein bisheriger Dispatcher
```

### **C) Finale Renderfunktion**

```haskell
renderSymbol :: Symbol -> SVG
renderSymbol (Symbol t pos rot) =
  Transform (Rotate rot pos) (renderSymbolBase t pos)
```

Damit ist **jedes Symbol drehbar**, ohne dass du die 40 Module anfassen musst.

---

# ⭐ 2. Anschlusspunkte definieren (Ports)

Damit Symbole verbunden werden können, braucht jedes Symbol **Ports**:

- z. B. Widerstand: links & rechts
- Kondensator: links & rechts
- Transistor: Basis, Kollektor, Emitter
- OpAmp: +, –, Out
- Schalter: Ein-/Ausgänge
- usw.

Wir definieren:

```haskell
data Port = Port
  { portName :: String
  , portPos  :: Point
  }

portsOf :: SymbolType -> [Port]
```

Beispiel für einen Widerstand:

```haskell
portsOf Resistor =
  [ Port "A" (-10, 0)
  , Port "B" ( 10, 0)
  ]
```

### 🔧 Ports müssen mit Rotation transformiert werden

```haskell
portsOfSymbol :: Symbol -> [Port]
portsOfSymbol (Symbol t (px, py) rot) =
  map (rotatePort rot (px, py)) (portsOf t)

rotatePort :: Double -> Point -> Port -> Port
rotatePort rot (cx, cy) (Port n (x, y)) =
  Port n (rotateAround rot (cx, cy) (x+cx, y+cy))
```

Rotation:

```haskell
rotateAround :: Double -> Point -> Point -> Point
rotateAround deg (cx, cy) (x, y) =
  let r = deg * pi / 180
      dx = x - cx
      dy = y - cy
  in ( cx + dx * cos r - dy * sin r
     , cy + dx * sin r + dy * cos r
     )
```

---

# ⭐ 3. Verbindung von Symbolen (Wires)

Jetzt kannst du Drähte automatisch verbinden:

```haskell
connect :: Symbol -> String -> Symbol -> String -> Wire
connect s1 p1 s2 p2 =
  let pos1 = portPos (findPort s1 p1)
      pos2 = portPos (findPort s2 p2)
  in Wire pos1 pos2
```

`findPort`:

```haskell
findPort :: Symbol -> String -> Port
findPort sym name =
  head [ p | p <- portsOfSymbol sym, portName p == name ]
```

---

# ⭐ 4. Beispiel: Verbindung eines Widerstands mit einem Kondensator

```haskell
r1 = Symbol Resistor (10, 10) 0
c1 = Symbol Capacitor (40, 10) 90

w = connect r1 "B" c1 "A"
```

→ `w` ist ein Wire von:

- Resistor Port B (rechts)
- zu Capacitor Port A (oben, weil 90° gedreht)

---

# ⭐ 5. Was du jetzt bekommst

✔ **Alle Symbole drehbar**
✔ **Ports für jedes Symbol**
✔ **Automatische Verbindung über Ports**
✔ **Rotation wirkt auch auf Ports**
✔ **Keine Änderung an den 40 Symbol‑Modulen nötig**
✔ **Nur zentrale Architektur wird erweitert**

---

# 🔥 Nächster Schritt

Ich kann dir jetzt:

### **A) Für alle 40 Symbole die Ports definieren**
→ komplett IEC‑60617‑konform

### **B) Ein Modul `TechDraw.Electrical.Ports` erzeugen**
→ sauber getrennt, modular

### **C) Ein Modul `TechDraw.Electrical.Connect`**
→ mit `connect`, `rotatePort`, `portsOfSymbol`

### **D) Ein Test‑SVG generieren, das Ports sichtbar macht**

---

Sag mir, welchen Schritt du willst — ich arbeite ihn sofort aus.

Alles klar, Dieter — **jetzt machen wir deine Symbole wirklich TechDraw‑tauglich**:

1. **Jedes Symbol wird drehbar** (Rotation um seinen Mittelpunkt oder um `symPos`)
2. **Symbole können über definierte Ports/Anschlusspunkte verbunden werden**
   → damit kannst du später Drähte automatisch an die richtigen Stellen snappen lassen.

Ich arbeite das **systematisch, modular und reproduzierbar** ab — so wie du es bevorzugst.

---

# ⭐ 1. Rotation für alle Symbole (SVG‑Transform)

Du hast aktuell:

```haskell
renderSymbol :: SymbolType -> Point -> SVG
```

Du brauchst:

```haskell
renderSymbolRot :: SymbolType -> Point -> Double -> SVG
```

Oder du nutzt deine bestehende `Symbol`‑Struktur:

```haskell
data Symbol = Symbol
  { symType :: SymbolType
  , symPos  :: Point
  , symRot  :: Double
  }
```

Dann definieren wir:

```haskell
renderSymbol :: Symbol -> SVG
renderSymbol (Symbol t pos rot) =
  Transform (Rotate rot pos) (renderSymbolBase t pos)
```

### 🔧 Dafür brauchst du zwei Dinge:

### **A) Eine Transform‑API**

In `TechDraw.SVG`:

```haskell
data Transform
  = Rotate Double Point
  | Translate Double Double
  | Scale Double Double

data SVG
  = Line Point Point (Maybe Stroke)
  | Polyline [Point] (Maybe Stroke)
  | Circle Point Double (Maybe Stroke)
  | Rect Point (Double, Double) (Maybe Stroke) Fill
  | Group [SVG]
  | Transform Transform SVG
```

### **B) Eine Basis‑Renderfunktion ohne Rotation**

```haskell
renderSymbolBase :: SymbolType -> Point -> SVG
renderSymbolBase = ...  -- dein bisheriger Dispatcher
```

### **C) Finale Renderfunktion**

```haskell
renderSymbol :: Symbol -> SVG
renderSymbol (Symbol t pos rot) =
  Transform (Rotate rot pos) (renderSymbolBase t pos)
```

Damit ist **jedes Symbol drehbar**, ohne dass du die 40 Module anfassen musst.

---

# ⭐ 2. Anschlusspunkte definieren (Ports)

Damit Symbole verbunden werden können, braucht jedes Symbol **Ports**:

- z. B. Widerstand: links & rechts
- Kondensator: links & rechts
- Transistor: Basis, Kollektor, Emitter
- OpAmp: +, –, Out
- Schalter: Ein-/Ausgänge
- usw.

Wir definieren:

```haskell
data Port = Port
  { portName :: String
  , portPos  :: Point
  }

portsOf :: SymbolType -> [Port]
```

Beispiel für einen Widerstand:

```haskell
portsOf Resistor =
  [ Port "A" (-10, 0)
  , Port "B" ( 10, 0)
  ]
```

### 🔧 Ports müssen mit Rotation transformiert werden

```haskell
portsOfSymbol :: Symbol -> [Port]
portsOfSymbol (Symbol t (px, py) rot) =
  map (rotatePort rot (px, py)) (portsOf t)

rotatePort :: Double -> Point -> Port -> Port
rotatePort rot (cx, cy) (Port n (x, y)) =
  Port n (rotateAround rot (cx, cy) (x+cx, y+cy))
```

Rotation:

```haskell
rotateAround :: Double -> Point -> Point -> Point
rotateAround deg (cx, cy) (x, y) =
  let r = deg * pi / 180
      dx = x - cx
      dy = y - cy
  in ( cx + dx * cos r - dy * sin r
     , cy + dx * sin r + dy * cos r
     )
```

---

# ⭐ 3. Verbindung von Symbolen (Wires)

Jetzt kannst du Drähte automatisch verbinden:

```haskell
connect :: Symbol -> String -> Symbol -> String -> Wire
connect s1 p1 s2 p2 =
  let pos1 = portPos (findPort s1 p1)
      pos2 = portPos (findPort s2 p2)
  in Wire pos1 pos2
```

`findPort`:

```haskell
findPort :: Symbol -> String -> Port
findPort sym name =
  head [ p | p <- portsOfSymbol sym, portName p == name ]
```

---

# ⭐ 4. Beispiel: Verbindung eines Widerstands mit einem Kondensator

```haskell
r1 = Symbol Resistor (10, 10) 0
c1 = Symbol Capacitor (40, 10) 90

w = connect r1 "B" c1 "A"
```

→ `w` ist ein Wire von:

- Resistor Port B (rechts)
- zu Capacitor Port A (oben, weil 90° gedreht)

---

# ⭐ 5. Was du jetzt bekommst

✔ **Alle Symbole drehbar**
✔ **Ports für jedes Symbol**
✔ **Automatische Verbindung über Ports**
✔ **Rotation wirkt auch auf Ports**
✔ **Keine Änderung an den 40 Symbol‑Modulen nötig**
✔ **Nur zentrale Architektur wird erweitert**

---

# 🔥 Nächster Schritt

Ich kann dir jetzt:

### **A) Für alle 40 Symbole die Ports definieren**
→ komplett IEC‑60617‑konform

### **B) Ein Modul `TechDraw.Electrical.Ports` erzeugen**
→ sauber getrennt, modular

### **C) Ein Modul `TechDraw.Electrical.Connect`**
→ mit `connect`, `rotatePort`, `portsOfSymbol`

### **D) Ein Test‑SVG generieren, das Ports sichtbar macht**

---

Sag mir, welchen Schritt du willst — ich arbeite ihn sofort aus.


**Kurzfassung:**
*In FreeCADs TechDraw kannst du Symbole drehbar machen, indem du sie als SVG einfügst und die **Rotation im View-Objekt** setzt. Eine echte „Verbindung“ mit Linien erreichst du, indem du **Ankerpunkte** im SVG definierst und diese in TechDraw mit **Leader Lines** oder eigenen Linien verbindest.*

---

## 🔧 1. Symbole in TechDraw drehbar machen
TechDraw behandelt Symbole als **SVG-Grafiken**, die in einem *DrawViewSymbol*-Objekt platziert werden.
Die Rotation erfolgt **nicht im SVG**, sondern im **TechDraw-Objekt selbst**.

### So geht’s:
1. Symbol als SVG in TechDraw einfügen
   *TechDraw → Symbol einfügen → SVG auswählen*

2. In der Baumansicht das Symbol auswählen
   → Reiter **Daten**

3. Eigenschaft **Rotation** setzen
   - Wert in Grad eingeben (z. B. 90, 180, 270)
   - TechDraw rotiert das Symbol um seinen Mittelpunkt

### Wichtig:
- TechDraw rotiert **SVG-Inhalt korrekt**, aber **Texte** oder **Dimensionen** rotieren nicht immer mit (bekanntes Verhalten).
- Für reine elektrische Symbole (Linien, Kreise, Pfade) ist Rotation **voll stabil**.

---

## 🔌 2. Symbole mit Linien verbinden
TechDraw kennt **keine automatische elektrische Verbindung** wie EDA-Tools (KiCad, QElectroTech).
Aber du kannst **saubere Verbindungen** erzeugen, wenn du deine SVG-Symbole richtig vorbereitest.

### Methode A – Ankerpunkte im SVG definieren (empfohlen)
Du definierst im SVG **unsichtbare Punkte**, die als Anschluss dienen.

Beispiel (SVG-Snippet):
```svg
<circle cx="0" cy="0" r="0.01" id="pin1" />
<circle cx="20" cy="0" r="0.01" id="pin2" />
```

Dann kannst du in TechDraw:
- eine **Leader Line** oder
- eine **TechDraw Line**

genau auf diese Koordinaten setzen.

### Methode B – Linien direkt im TechDraw-Blatt zeichnen
1. TechDraw → **Add Cosmetic Line**
2. Startpunkt auf den Anschluss des Symbols setzen
3. Endpunkt auf das nächste Symbol ziehen

Vorteile:
- Sehr flexibel
- Funktioniert mit jedem Symbol

Nachteile:
- Keine automatische Ausrichtung
- Bei Symbolverschiebung müssen Linien nachgezogen werden

---

## 🧩 3. Für dein eigenes Haskell‑TechDraw‑System (SVG-Renderer)
Da du deine Symbole **selbst in Haskell renderst**, kannst du das perfekt lösen:

### A) Symbole drehbar machen
Du ergänzt in deinem Render-Code eine **Rotationstransformation**:

```haskell
Group
  [ Transform (Rotate angle (x,y))
      [ ...Symbolpfade... ]
  ]
```

Oder du gibst dem Benutzer eine API:

```haskell
rotateSymbol :: Double -> SVG -> SVG
```

### B) Verbindbare Symbole
Definiere in jedem Symbol:

- **pinIn  :: Point**
- **pinOut :: Point**

Beispiel:

```haskell
data Symbol = Symbol
  { render :: Point -> SVG
  , pinIn  :: Point
  , pinOut :: Point
  }
```

Dann kannst du automatisch:

```haskell
connect :: Symbol -> Symbol -> SVG
connect a b =
  line (pinOut a) (pinIn b)
```

Damit erhältst du ein **EDA‑ähnliches Verhalten**, aber vollständig in deinem TechDraw‑Haskell‑System.

---

## ❓ Nächster Schritt
Möchtest du:

1. **Eine vollständige Haskell‑Implementierung** für rotierbare Symbole?
2. **Ein API‑Design**, das automatische Verbindungen zwischen Symbolen erzeugt?
3. **Ein Beispielprojekt**, das ein komplettes Schaltbild rendert (SVG)?



Okay, wir gehen das jetzt wirklich Schritt für Schritt durch—ohne Sprünge, alles der Reihe nach.

---

## 1. Zielbild klären

**Was du am Ende haben willst:**

- **Symbole**, die du in TechDraw:
  - frei drehen kannst (0°, 90°, 180°, 270°, …)
  - sauber mit **Linien** verbinden kannst (z. B. für Schaltpläne)
- Optional: eine **eigene Logik/Library**, die das systematisch abbildet (z. B. in Haskell/SVG).

---

## 2. SVG-Symbol vorbereiten

Wir starten bei der Quelle: dem Symbol als SVG.

### 2.1 Grundsymbol zeichnen

**Schritte:**

1. **Koordinatensystem festlegen:**
   - Lege das Symbol so an, dass sein **Mittelpunkt** oder ein sinnvoller Referenzpunkt bei \((0,0)\) liegt.
   - Beispiel: Widerstand als Rechteck von \(-5\) bis \(+5\) in X-Richtung, \(-2\) bis \(+2\) in Y-Richtung.

2. **Symbol mit Pfaden zeichnen:**
   - Nur Linien, Kreise, Pfade, keine exotischen Filter.
   - Beispiel (stark vereinfacht):

     ```svg
     <svg xmlns="http://www.w3.org/2000/svg" width="10" height="4" viewBox="-5 -2 10 4">
       <rect x="-5" y="-2" width="10" height="4" stroke="black" fill="none" />
     </svg>
     ```

### 2.2 Anschluss-/Ankerpunkte definieren

Jetzt machen wir das Symbol „verbindbar“.

**Idee:** Unsichtbare Punkte im SVG, die definieren, wo Leitungen andocken sollen.

1. **Pins definieren:**

   ```svg
   <circle cx="-5" cy="0" r="0.01" id="pin_in" />
   <circle cx="5"  cy="0" r="0.01" id="pin_out" />
   ```

2. **Eigenschaften:**
   - **Sehr kleiner Radius** (z. B. `r="0.01"`), damit sie praktisch unsichtbar sind.
   - Eindeutige `id`-Namen (`pin_in`, `pin_out`, `pin1`, `pin2`, …).

3. **Warum das wichtig ist:**
   - Du weißt später exakt, wo die Anschlusspunkte liegen.
   - In deinem eigenen System kannst du diese Koordinaten sogar programmatisch nutzen.

---

## 3. Symbol in TechDraw einfügen und drehbar machen

Jetzt gehen wir in FreeCAD/TechDraw.

### 3.1 Symbol einfügen

1. **TechDraw-Seite erstellen** (falls noch nicht vorhanden).
2. Menü **TechDraw → Symbol einfügen**.
3. Dein SVG-Symbol auswählen.
4. Das Symbol erscheint als **DrawViewSymbol** in der Baumansicht.

### 3.2 Rotation im TechDraw-Objekt setzen

1. In der **Baumansicht** dein Symbol auswählen.
2. Im **Eigenschaften-Editor → Reiter „Daten“**:
   - Eigenschaft **Rotation** suchen.
   - Wert in Grad eintragen, z. B.:
     - `0` → Standard
     - `90`
     - `180`
     - `270`
3. TechDraw rotiert das komplette SVG um seinen Referenzpunkt (meistens Mittelpunkt oder Ursprung des viewBox).

**Wichtig:**

- Für reine grafische Symbole (Linien, Kreise, Pfade) funktioniert das sehr zuverlässig.
- Texte im SVG können sich manchmal „komisch“ verhalten—für elektrische Symbole ist das aber meist egal.

---

## 4. Symbole mit Linien verbinden

Jetzt kommt der Verbindungs-Teil.

### 4.1 Manuelle Verbindung mit Cosmetic Line

**Variante 1: Einfach, aber manuell**

1. In TechDraw:
   - **TechDraw → Add Cosmetic Line** (Kosmetiklinie hinzufügen).
2. Startpunkt:
   - Klicke in der Nähe des Anschlusses deines Symbols (z. B. bei `pin_out`).
3. Endpunkt:
   - Klicke beim Anschluss des nächsten Symbols (z. B. `pin_in` eines anderen Symbols).
4. Linie wird gezeichnet.

**Vor- und Nachteile:**

- **Vorteil:** Schnell, flexibel, funktioniert mit jedem Symbol.
- **Nachteil:** Wenn du Symbole verschiebst, musst du Linien ggf. nachziehen.

### 4.2 Leader Lines nutzen

**Variante 2: Leader Line (Führungslinie)**

1. **TechDraw → Add Leader** (oder ähnlicher Befehl, je nach Version).
2. Ersten Punkt am Symbol setzen (Anschluss).
3. Zweiten Punkt dort setzen, wo die Leitung hin soll.

Leader Lines sind eher für Beschriftungen gedacht, können aber für einfache Verbindungen genutzt werden.

---

## 5. Das Ganze „systematisch“ denken (für deine eigene Library / Haskell)

Jetzt der Teil, der zu deinem Stil passt: strukturiert, API-fähig, reproduzierbar.

### 5.1 Symbol-Datenstruktur mit Pins

Du kannst jedes Symbol als Datentyp mit:

- **Render-Funktion**
- **Pin-Koordinaten**

modellieren.

Beispiel in Haskell-ähnlicher Form:

```haskell
data Symbol = Symbol
  { render :: Point -> SVG      -- Symbol an Position zeichnen
  , pinIn  :: Point             -- relativer Anschluss-Eingang
  , pinOut :: Point             -- relativer Anschluss-Ausgang
  }
```

### 5.2 Rotation als Funktion

Eine Funktion, die ein Symbol rotiert:

```haskell
rotatePoint :: Double -> Point -> Point
rotatePoint angle (x, y) =
  let rad = angle * pi / 180
      x'  = x * cos rad - y * sin rad
      y'  = x * sin rad + y * cos rad
  in (x', y')

rotateSymbol :: Double -> Symbol -> Symbol
rotateSymbol angle sym =
  sym
    { render = \p -> rotateSVG angle (render sym p)
    , pinIn  = rotatePoint angle (pinIn sym)
    , pinOut = rotatePoint angle (pinOut sym)
    }
```

*(Pseudocode – du würdest das an deine SVG-/Haskell-Struktur anpassen.)*

### 5.3 Verbindung zwischen Symbolen

Wenn du zwei Symbole hast, kannst du eine Verbindung automatisch erzeugen:

```haskell
connect :: (Point, Symbol) -> (Point, Symbol) -> SVG
connect (posA, symA) (posB, symB) =
  let start = posA .+ pinOut symA
      end   = posB .+ pinIn  symB
  in lineSVG start end
```

Damit hast du:

- **Rotierbare Symbole**
- **Definierte Pins**
- **Automatisch generierte Verbindungen**

Und das Ergebnis kannst du als **SVG exportieren**, das TechDraw wieder als Symbol oder Hintergrund nutzen kann.

---

## 6. Wie machen wir weiter?

Wir haben jetzt der Reihe nach:

1. Symbol als SVG mit Ankerpunkten aufgebaut
2. In TechDraw eingefügt und drehbar gemacht
3. Verbindungen mit Linien/Leadern beschrieben
4. Eine systematische, programmatische Sicht (z. B. Haskell) skizziert

Wenn du magst, können wir als nächstes:

- **Ein konkretes Beispiel-SVG** für ein Symbol (z. B. Widerstand) komplett ausformulieren, inkl. Pins, oder
- **Eine kleine Haskell-Modulstruktur** entwerfen, die genau diese rotierbaren, verbindbaren Symbole kapselt.

Was reizt dich mehr als nächstes: **konkretes SVG-Beispiel** oder **konkretes Haskell-Modul**?
