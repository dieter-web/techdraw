-- file: src/TechDraw/Electrical/Symbols/LED.hs
module TechDraw.Electrical.Symbols.LED
  ( renderLED
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types

import TechDraw.Electrical.Symbols.Diode

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderLED :: Pos -> SVG
renderLED (x, y) =
  Group
    [ renderDiode (x, y)
      -- Pfeile nach außen
    , Polyline
        [ (x+6, y-10)
        , (x+10, y-14)
        , (x+10, y-10)
        ]
        stroke
    , Line (x+6, y-10) (x+12, y-10) stroke
    , Polyline
        [ (x+8, y-6)
        , (x+12, y-10)
        , (x+12, y-6)
        ]
        stroke
    , Line (x+8, y-6) (x+14, y-6) stroke
    ]
