-- file: src/TechDraw/Electrical/Symbols/Zener.hs
module TechDraw.Electrical.Symbols.Zener
  ( renderZener
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderZener :: Pos -> SVG
renderZener (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Polyline
        [ (x-4,  y-6)
        , (x+4,  y)
        , (x-4,  y+6)
        , (x-4,  y-6)
        ]
        stroke
    , Polyline
        [ (x+4, y-6)
        , (x+4, y+6)
        , (x+6, y+4)
        ]
        stroke
    , Line (x+6, y) (x+16, y) stroke
    ]
