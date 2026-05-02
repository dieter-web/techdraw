-- file: src/TechDraw/Electrical/Symbols/SwitchClosed.hs
module TechDraw.Electrical.Symbols.SwitchClosed
  ( renderSwitchClosed
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderSwitchClosed :: Pos -> SVG
renderSwitchClosed (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Line (x+4,  y) (x+16, y) stroke
    , Line (x-4,  y) (x+4,  y) stroke
    ]
