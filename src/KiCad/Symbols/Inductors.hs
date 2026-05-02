module TechDraw.Electrical.Symbols.Inductors
  ( renderInductor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

-- IEC-Spule: 4 Bögen
renderInductor :: Point -> SVG
renderInductor (x,y) =
  Path
    [ MoveTo x y
    , ArcTo 5 5 0 False True (x+10) y
    , ArcTo 5 5 0 False True (x+20) y
    , ArcTo 5 5 0 False True (x+30) y
    , ArcTo 5 5 0 False True (x+40) y
    ]
    stroke
    FillNone
