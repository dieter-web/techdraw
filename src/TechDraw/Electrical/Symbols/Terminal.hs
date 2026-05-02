-- file: src/TechDraw/Electrical/Symbols/Terminal.hs
module TechDraw.Electrical.Symbols.Terminal
  ( renderTerminal
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderTerminal :: Pos -> SVG
renderTerminal (x, y) =
  Group
    [ Line (x-12, y) (x, y) stroke
    , Circle (x, y) 3 stroke FillNone
    ]
