-- file: src/TechDraw/Electrical/Symbols/CapacitorPolarized.hs
module TechDraw.Electrical.Symbols.CapacitorPolarized
  ( renderCapacitorPolarized
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderCapacitorPolarized :: Pos -> SVG
renderCapacitorPolarized (x, y) =
  Group
    [ Line (x-12, y) (x-2, y) stroke
    , Line (x-2, y-8) (x-2, y+8) stroke
    , Line (x+2, y-8) (x+2, y+8) stroke
    , Line (x+2, y) (x+12, y) stroke
      -- Pluszeichen an der rechten Platte
    , Line (x+6, y-5) (x+6, y+1) stroke
    , Line (x+3, y-2) (x+9, y-2) stroke
    ]

