-- file: src/TechDraw/Electrical/Symbols/SwitchOpen.hs
module TechDraw.Electrical.Symbols.SwitchOpen
  ( renderSwitchOpen
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderSwitchOpen :: Pos -> SVG
renderSwitchOpen (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Line (x+4,  y) (x+16, y) stroke
    , Line (x-4,  y) (x+4,  y-6) stroke
    ]
