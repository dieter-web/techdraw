module TechDraw.Electrical.Symbols.Motors
  ( renderMotor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderMotor :: Point -> SVG
renderMotor (x,y) =
  Group
    [ Circle (x+20,y) 15 (Just (StrokeColor "black" 1)) FillNone
    , Text (x+20,y+5) AnchorMiddle "M"
    ]
