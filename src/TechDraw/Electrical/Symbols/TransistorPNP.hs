-- file: src/TechDraw/Electrical/Symbols/TransistorPNP.hs
module TechDraw.Electrical.Symbols.TransistorPNP
  ( renderTransistorPNP
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderTransistorPNP :: Pos -> SVG
renderTransistorPNP (x, y) =
  Group
    [ Circle (x, y) 8 stroke FillNone
      -- Kollektor
    , Line (x+8, y-4) (x+16, y-8) stroke
      -- Emitter mit Pfeil nach innen
    , Line (x+8, y+4) (x+16, y+8) stroke
    , Polyline
        [ (x+16, y+8)
        , (x+12, y+6)
        , (x+14, y+10)
        ]
        stroke
      -- Basis
    , Line (x-16, y) (x-8, y) stroke
    , Line (x-8, y) (x-2, y) stroke
    ]
