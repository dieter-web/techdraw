-- file: src/TechDraw/Electrical/Symbols/PushButtonNO.hs
module TechDraw.Electrical.Symbols.PushButtonNO
  ( renderPushButtonNO
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderPushButtonNO :: Pos -> SVG
renderPushButtonNO (x, y) =
  Group
    [ Line (x-16, y) (x-4, y) stroke
    , Line (x+4,  y) (x+16, y) stroke
    , Line (x-4,  y) (x+4,  y-6) stroke
    , Circle (x, y-8) 2 stroke FillNone
    ]
