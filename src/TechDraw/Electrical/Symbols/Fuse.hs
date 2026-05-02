-- file: src/TechDraw/Electrical/Symbols/Fuse.hs
module TechDraw.Electrical.Symbols.Fuse
  ( renderFuse
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderFuse :: Pos -> SVG
renderFuse (x, y) =
  Group
    [ Line (x-16, y) (x-8, y) stroke
    , Rect (x-8, y-4) (16, 8)(Just (StrokeColor "black" 0.5)) FillNone
    , Line (x+8, y) (x+16, y) stroke
    ]
