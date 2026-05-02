-- file: src/TechDraw/Electrical/Symbols/SwitchDPDT.hs
module TechDraw.Electrical.Symbols.SwitchDPDT
  ( renderSwitchDPDT
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderSwitchDPDT :: Pos -> SVG
renderSwitchDPDT (x, y) =
  Group
    [ -- obere Ebene
      Line (x-16, y-4) (x-4, y-4) stroke
    , Line (x+4,  y-10) (x+16, y-10) stroke
    , Line (x+4,  y-4) (x+16, y-4) stroke
    , Line (x-4,  y-4) (x+4, y-10) stroke
      -- untere Ebene
    , Line (x-16, y+4) (x-4, y+4) stroke
    , Line (x+4,  y+10) (x+16, y+10) stroke
    , Line (x+4,  y+4) (x+16, y+4) stroke
    , Line (x-4,  y+4) (x+4, y+10) stroke
    ]
