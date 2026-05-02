-- file: src/TechDraw/Electrical/Symbols/CapacitorTrimmer.hs
module TechDraw.Electrical.Symbols.CapacitorTrimmer
  ( renderCapacitorTrimmer
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderCapacitorTrimmer :: Pos -> SVG
renderCapacitorTrimmer (x, y) =
  Group
    [ Line (x-12, y) (x-2, y) stroke
    , Line (x-2, y-8) (x-2, y+8) stroke
    , Line (x+2, y-8) (x+2, y+8) stroke
    , Line (x+2, y) (x+12, y) stroke
      -- Trimmer-Schraube
    , Line (x-4, y-10) (x+8, y+2) stroke
    , Line (x-1, y-13) (x+5, y-7) stroke
    ]
