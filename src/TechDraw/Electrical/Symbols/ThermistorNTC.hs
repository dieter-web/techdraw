-- file: src/TechDraw/Electrical/Symbols/ThermistorNTC.hs
module TechDraw.Electrical.Symbols.ThermistorNTC
  ( renderThermistorNTC
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderThermistorNTC :: Pos -> SVG
renderThermistorNTC (x, y) =
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
      -- NTC Kennzeichnung: diagonale Linie mit "-"
    , Line (x+6, y-8) (x+14, y-16) stroke
    , Line (x+11, y-16) (x+17, y-16) stroke
    ]
