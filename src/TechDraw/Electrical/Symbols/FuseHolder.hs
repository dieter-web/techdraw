-- file: src/TechDraw/Electrical/Symbols/FuseHolder.hs
module TechDraw.Electrical.Symbols.FuseHolder
  ( renderFuseHolder
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderFuseHolder :: Pos -> SVG
renderFuseHolder (x, y) =
  Group
    [ Line (x-18, y) (x-10, y) stroke
    , Rect (x-10, y-4) (20, 8) (Just (StrokeColor "black" 0.5)) FillNone
    , Line (x+10, y) (x+18, y) stroke
    ]
