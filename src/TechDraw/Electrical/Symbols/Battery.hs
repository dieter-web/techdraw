-- file: src/TechDraw/Electrical/Symbols/Battery.hs
module TechDraw.Electrical.Symbols.Battery
  ( renderBattery
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderBattery :: Pos -> SVG
renderBattery (x, y) =
  Group
    [ Line (x-16, y) (x-8, y) stroke
    , Line (x-8, y-10) (x-8, y+10) stroke
    , Line (x-4, y-6) (x-4, y+6) stroke
    , Line (x-4, y) (x+8, y) stroke
    ]
