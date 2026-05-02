-- file: src/TechDraw/Electrical/Symbols/PushButtonNC.hs
module TechDraw.Electrical.Symbols.PushButtonNC
  ( renderPushButtonNC
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderPushButtonNC :: Pos -> SVG
renderPushButtonNC (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Line (x+4,  y) (x+16, y) stroke
    , Line (x-4,  y) (x+4,  y) stroke
    , Circle (x, y-8) 2 stroke FillNone
    ]
