module TechDraw.SVG.Types (
    Pos,
    Length,
    Pt,
)
where

import TechDraw.SVG.Path

-- type Coord = Double
-- type Pos = (Coord, Coord) -- Umschreibung für Point, weil sonst doppelt
type Pos = (Double, Double)
type Length = Double
type Pt = (Double, Double)
