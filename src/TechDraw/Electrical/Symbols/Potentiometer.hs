-- file: src/TechDraw/Electrical/Symbols/Potentiometer.hs
module TechDraw.Electrical.Symbols.Potentiometer
  ( renderPotentiometer
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderPotentiometer :: Pos -> SVG
renderPotentiometer (x, y) =
  Group
    [ -- Basis: Widerstand
      Line (x-10, y) (x-2, y) stroke
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
      -- Schleifer diagonal
    , Line (x+4, y-10) (x+4, y+4) stroke
    , Line (x+4, y-10) (x+10, y-16) stroke
    ]
