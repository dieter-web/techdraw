-- file: src/TechDraw/Electrical/Symbols/Capacitor.hs
module TechDraw.Electrical.Symbols.Capacitor
  ( renderCapacitor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderCapacitor :: Pos -> SVG
renderCapacitor (x, y) =
  Group
    [ Line (x-12, y) (x-2, y) stroke
    , Line (x-2, y-8) (x-2, y+8) stroke
    , Line (x+2, y-8) (x+2, y+8) stroke
    , Line (x+2, y) (x+12, y) stroke
    ]
