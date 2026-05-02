-- file: src/TechDraw/Electrical/Symbols/Ground.hs
module TechDraw.Electrical.Symbols.Ground
  ( renderGround
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderGround :: Pos -> SVG
renderGround (x, y) =
  Group
    [ Line (x, y-8) (x, y) stroke
    , Line (x-8, y) (x+8, y) stroke
    , Line (x-6, y+3) (x+6, y+3) stroke
    , Line (x-4, y+6) (x+4, y+6) stroke
    ]
