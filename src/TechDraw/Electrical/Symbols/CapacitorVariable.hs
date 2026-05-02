-- file: src/TechDraw/Electrical/Symbols/CapacitorVariable.hs
module TechDraw.Electrical.Symbols.CapacitorVariable
  ( renderCapacitorVariable
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderCapacitorVariable :: Pos -> SVG
renderCapacitorVariable (x, y) =
  Group
    [ Line (x-12, y) (x-2, y) stroke
    , Line (x-2, y-8) (x-2, y+8) stroke
    , Line (x+2, y-8) (x+2, y+8) stroke
    , Line (x+2, y) (x+12, y) stroke
      -- Diagonaler Pfeil
    , Line (x-4, y-10) (x+8, y+2) stroke
    , Line (x+6, y+2) (x+8, y) stroke
    , Line (x+6, y+2) (x+8, y+4) stroke
    ]
