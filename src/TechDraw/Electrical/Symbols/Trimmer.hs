-- file: src/TechDraw/Electrical/Symbols/Trimmer.hs
module TechDraw.Electrical.Symbols.Trimmer
  ( renderTrimmer
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderTrimmer :: Pos -> SVG
renderTrimmer (x, y) =
  Group
    [ Line (x-10, y) (x-2, y) stroke
    , Polyline
        [ (x-2,  y)
        , (x,    y-4)
        , (x+4,  y+4)
        , (x+8,  y-4)
        , (x+12, y+4)
        , (x+16, y-4)
        , (x+18, y)
        ]
        stroke
    , Line (x+18, y) (x+26, y) stroke
      -- Trimmer-Schraube
    , Line (x+4, y-10) (x+4, y+4) stroke
    , Line (x+1, y-13) (x+7, y-7) stroke
    ]
