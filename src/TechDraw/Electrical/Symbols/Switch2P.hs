-- file: src/TechDraw/Electrical/Symbols/Switch2P.hs
module TechDraw.Electrical.Symbols.Switch2P
  ( renderSwitch2P
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderSwitch2P :: Pos -> SVG
renderSwitch2P (x, y) =
  Group
    [ -- oberer Pol
      Line (x-16, y-4) (x-4, y-4) stroke
    , Line (x+4,  y-4) (x+16, y-4) stroke
    , Line (x-4,  y-4) (x+4,  y-8) stroke
      -- unterer Pol
    , Line (x-16, y+4) (x-4, y+4) stroke
    , Line (x+4,  y+4) (x+16, y+4) stroke
    , Line (x-4,  y+4) (x+4,  y) stroke
    ]
