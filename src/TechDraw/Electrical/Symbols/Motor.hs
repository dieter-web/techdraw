-- file: src/TechDraw/Electrical/Symbols/Motor.hs
module TechDraw.Electrical.Symbols.Motor
  ( renderMotor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderMotor :: Pos -> SVG
renderMotor (x, y) =
  Group
    [ Circle (x, y) 10 stroke FillNone
    , Line (x-16, y) (x-10, y) stroke
    , Line (x+10, y) (x+16, y) stroke
    , Line (x-4, y-4) (x+4, y+4) stroke
    , Line (x-4, y+4) (x+4, y-4) stroke
    ]
