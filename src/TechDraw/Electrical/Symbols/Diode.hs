-- file: src/TechDraw/Electrical/Symbols/Diode.hs
module TechDraw.Electrical.Symbols.Diode
  ( renderDiode
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderDiode :: Pos -> SVG
renderDiode (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Polyline
        [ (x-4,  y-6)
        , (x+4,  y)
        , (x-4,  y+6)
        , (x-4,  y-6)
        ]
        stroke
    , Line (x+4, y-6) (x+4, y+6) stroke
    , Line (x+4, y) (x+16, y) stroke
    ]
