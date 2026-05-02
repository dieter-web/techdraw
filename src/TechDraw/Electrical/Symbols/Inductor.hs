-- file: src/TechDraw/Electrical/Symbols/Inductor.hs
module TechDraw.Electrical.Symbols.Inductor
  ( renderInductor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)-- anstelle von Point

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderInductor :: Pos -> SVG
renderInductor (x, y) =
  Group
    [ Line (x-12, y) (x-4, y) stroke
    , Polyline
        [ (x-4,  y)
        , (x,    y-6)
        , (x+4,  y)
        , (x+8,  y-6)
        , (x+12, y)
        , (x+16, y-6)
        , (x+20, y)
        ]
        stroke
    , Line (x+20, y) (x+28, y) stroke
    ]
