-- file: src/TechDraw/Electrical/Symbols/TransistorNPN.hs
module TechDraw.Electrical.Symbols.TransistorNPN
  ( renderTransistorNPN
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderTransistorNPN :: Pos -> SVG
renderTransistorNPN (x, y) =
  Group
    [ Circle (x, y) 8 stroke FillNone
      -- Kollektor
    , Line (x+8, y-4) (x+16, y-8) stroke
      -- Emitter mit Pfeil nach außen
    , Line (x+8, y+4) (x+16, y+8) stroke
    , Polyline
        [ (x+12, y+6)
        , (x+16, y+8)
        , (x+14, y+4)
        ]
        stroke
      -- Basis
    , Line (x-16, y) (x-8, y) stroke
    , Line (x-8, y) (x-2, y) stroke
    ]
