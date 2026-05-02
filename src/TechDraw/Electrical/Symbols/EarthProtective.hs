-- file: src/TechDraw/Electrical/Symbols/EarthProtective.hs
module TechDraw.Electrical.Symbols.EarthProtective
  ( renderEarthProtective
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderEarthProtective :: Pos -> SVG
renderEarthProtective (x, y) =
  Group
    [ Line (x, y-8) (x, y) stroke
    , Line (x-6, y) (x+6, y) stroke
    , Line (x-4, y+3) (x+4, y+3) stroke
    , Line (x-2, y+6) (x+2, y+6) stroke
    ]
