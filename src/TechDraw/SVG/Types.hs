module TechDraw.SVG.Types (
    Pos,
    Length,
    Pt,
    Transform (..)
)
where

import TechDraw.SVG.Paths

-- type Coord = Double
-- type Pos = (Coord, Coord) -- Umschreibung für Point, weil sonst doppelt
type Pos = (Double, Double)
type Length = Double
type Pt = (Double, Double)

data Transform
    = Translate Double Double
    | Rotate Double Pos
    | Scale Double Double
    | TransformList [Transform]
    deriving (Show, Eq)
