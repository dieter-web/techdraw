-- file: src/TechDraw/Electrical/Symbols/Resistor.hs
module TechDraw.Electrical.Symbols.Resistor
  ( renderResistor
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types 

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderResistor :: Pos -> SVG
renderResistor (x, y) =
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
    ]
