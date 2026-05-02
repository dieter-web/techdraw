-- file: src/TechDraw/Electrical/Symbols/Lamp.hs
module TechDraw.Electrical.Symbols.Lamp
  ( renderLamp
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderLamp :: Pos -> SVG
renderLamp (x, y) =
  Group
    [ Circle (x, y) 8 stroke FillNone
    , Line (x-16, y) (x-8, y) stroke
    , Line (x+8, y) (x+16, y) stroke
    , Line (x-5, y-5) (x+5, y+5) stroke
    , Line (x-5, y+5) (x+5, y-5) stroke
    ]
