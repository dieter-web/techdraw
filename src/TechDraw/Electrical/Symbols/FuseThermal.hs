-- file: src/TechDraw/Electrical/Symbols/FuseThermal.hs
module TechDraw.Electrical.Symbols.FuseThermal
  ( renderFuseThermal
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderFuseThermal :: Pos -> SVG
renderFuseThermal (x, y) =
  Group
    [ Line (x-16, y) (x-8, y) stroke
    , Rect (x-8, y-4) (16, 8) (Just (StrokeColor "black" 0.5)) FillNone
    , Line (x+8, y) (x+16, y) stroke
      -- Temperaturkennzeichnung
    , Line (x-4, y-8) (x+4, y-16) stroke
    ]
