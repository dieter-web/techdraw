-- file: src/TechDraw/Electrical/Symbols/CircuitBreaker.hs
module TechDraw.Electrical.Symbols.CircuitBreaker
  ( renderCircuitBreaker
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderCircuitBreaker :: Pos -> SVG
renderCircuitBreaker (x, y) =
  Group
    [ Line (x-16, y) (x-8, y) stroke
    , Rect (x-8, y-6) (16, 12) (Just (StrokeColor "black" 0.5)) FillNone
    , Line (x+8, y) (x+16, y) stroke
    , Line (x-4, y-6) (x+4, y+6) stroke
    ]
