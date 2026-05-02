-- file: src/TechDraw/Electrical/Symbols/DCSource.hs
module TechDraw.Electrical.Symbols.DCSource
  ( renderDCSource
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderDCSource :: Pos -> SVG
renderDCSource (x, y) =
  Group
    [ Circle (x, y) 10 stroke FillNone
    , Line (x-16, y) (x-10, y) stroke
    , Line (x+10, y) (x+16, y) stroke
      -- Plus
    , Line (x-2, y-4) (x+2, y-4) stroke
    , Line (x,   y-6) (x,   y-2) stroke
      -- Minus
    , Line (x-2, y+4) (x+2, y+4) stroke
    ]
