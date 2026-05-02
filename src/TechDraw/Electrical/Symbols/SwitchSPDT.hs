-- file: src/TechDraw/Electrical/Symbols/SwitchSPDT.hs
module TechDraw.Electrical.Symbols.SwitchSPDT
  ( renderSwitchSPDT
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderSwitchSPDT :: Pos -> SVG
renderSwitchSPDT (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Line (x+4,  y-6) (x+16, y-6) stroke
    , Line (x+4,  y+6) (x+16, y+6) stroke
    , Line (x-4,  y) (x+4, y-6) stroke
    ]
