module TechDraw.Electrical.Symbols.Capacitors
  ( renderCapacitor
  , renderCapacitorPolarized
  , renderVariableCapacitor
  , renderTrimmerCapacitor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path
import TechDraw.Electrical.Types


-- 1. Ungepolter Kondensator
-- Darstellung: ----| |----
renderCapacitor :: Point -> SVG
renderCapacitor (x,y) =
  Group
    [ Line (x, y) (x+10, y) stroke
    , Line (x+10, y-10) (x+10, y+10) stroke
    , Line (x+20, y-10) (x+20, y+10) stroke
    , Line (x+20, y) (x+40, y) stroke
    ]

-- 2. Elektrolytkondensator (gepolt)
-- Darstellung: ----| |)----
renderCapacitorPolarized :: Point -> SVG
renderCapacitorPolarized (x,y) =
  Group
    [ Line (x, y) (x+10, y) stroke
    , Line (x+10, y-10) (x+10, y+10) stroke
    , Path
        [ MoveTo (x+20)(y-10)
        , ArcTo 10 10 0 False True (x+20) (y+10)
        ] stroke FillNone
    , Line (x+20, y) (x+40, y) stroke
    ]

-- 3. Variabler Kondensator
-- Darstellung: Kondensator + diagonaler Pfeil
renderVariableCapacitor :: Point -> SVG
renderVariableCapacitor (x,y) =
  Group
    [ renderCapacitor (x,y)
    , Line (x+5, y-15) (x+25, y+15) stroke
    ]

-- 4. Trimmer-Kondensator
-- Darstellung: Kondensator + diagonaler Strich
renderTrimmerCapacitor :: Point -> SVG
renderTrimmerCapacitor (x,y) =
  Group
    [ renderCapacitor (x,y)
    , Line (x+5, y-15) (x+25, y+15) stroke
    , Line (x+15, y-5) (x+15, y+5) stroke
    ]
