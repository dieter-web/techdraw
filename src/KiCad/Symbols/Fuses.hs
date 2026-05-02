module TechDraw.Electrical.Symbols.Fuses
  ( renderFuse
  , renderFuseHolder
  , renderThermalFuse
  , renderCircuitBreaker
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path
import TechDraw.Electrical.Types

-- 1. Schmelzsicherung (IEC 60617-5017)
-- Darstellung: ----[ X ]----
renderFuse :: Point -> SVG
renderFuse (x,y) =
  Group
    [ Line (x, y) (x+10, y) stroke
    , Line (x+10, y-6) (x+30, y+6) stroke
    , Line (x+10, y+6) (x+30, y-6) stroke
    , Line (x+30, y) (x+40, y) stroke
    ]

-- 2. Sicherungshalter (IEC 60617-5018)
-- Darstellung: ----[   ]----
renderFuseHolder :: Point -> SVG
renderFuseHolder (x,y) =
  Group
    [ Line (x, y) (x+10, y) stroke
    , Rect (x+10, y-6) (20,12) stroke FillNone
    , Line (x+30, y) (x+40, y) stroke
    ]

-- 3. Thermosicherung (Temperatursicherung)
-- Darstellung: ----[ X ]---- mit Pfeil
renderThermalFuse :: Point -> SVG
renderThermalFuse (x,y) =
  Group
    [ renderFuse (x,y)
    , Line (x+20, y-10) (x+30, y) stroke
    , Line (x+20, y+10) (x+30, y) stroke
    ]

-- 4. Leitungsschutzschalter (LS-Schalter)
-- Darstellung: ----o/----
renderCircuitBreaker :: Point -> SVG
renderCircuitBreaker (x,y) =
  Group
    [ Line (x,y) (x+10, y) stroke
    , Circle (x+10, y) 2 {(Just (StrokeColor "black" 1))} FillNone
    , Line (x+10, y) (x+25, y-8) stroke
    , Line (x+25, y-8)(x+40, y-8) stroke
    ]
