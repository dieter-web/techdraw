module TechDraw.Electrical.Symbols.Resistors
  ( renderResistor
  , renderPotentiometer
  , renderTrimmer
  , renderThermistorPTC
  , renderThermistorNTC
  , renderVaristor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.Electrical.Types

-- 1. Widerstand (IEC 60617-4022)
-- Darstellung: ----[   ]----
renderResistor :: Point -> SVG
renderResistor (x,y) =
  Group
    [ Line (x, y) (x+10, y) stroke
    , Rect (x+10, y-6) (20,12) stroke FillNone
    , Line (x+30, y) (x+40, y) stroke
    ]

-- 2. Potentiometer
-- Darstellung: Widerstand + Pfeil
renderPotentiometer :: Point -> SVG
renderPotentiometer (x,y) =
  Group
    [ renderResistor (x,y)
    , Line (x+20, y-12) (x+20, y+12) stroke
    ]

-- 3. Trimmer (Einstellbarer Widerstand)
-- Darstellung: Widerstand + diagonaler Pfeil
renderTrimmer :: Point -> SVG
renderTrimmer (x,y) =
  Group
    [ renderResistor (x,y)
    , Line (x+10, y-12) (x+30, y+12) stroke
    ]

-- 4. Thermistor PTC
-- Darstellung: Widerstand + Pfeil nach oben
renderThermistorPTC :: Point -> SVG
renderThermistorPTC (x,y) =
  Group
    [ renderResistor (x,y)
    , Line (x+20, y-8) (x+20, y-16) stroke
    , Line (x+16, y-12) (x+24, y-12) stroke
    ]

-- 5. Thermistor NTC
-- Darstellung: Widerstand + Pfeil nach unten
renderThermistorNTC :: Point -> SVG
renderThermistorNTC (x,y) =
  Group
    [ renderResistor (x,y)
    , Line (x+20, y+8) (x+20, y+16) stroke
    , Line (x+16, y+12) (x+24, y) stroke
    ]

-- 6. Varistor
-- Darstellung: ...
renderVaristor :: Point -> SVG
renderVaristor (x,y) = renderResistor (x,y)

