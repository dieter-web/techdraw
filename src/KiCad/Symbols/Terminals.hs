module TechDraw.Electrical.Symbols.Terminals
  ( renderTerminal
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderTerminal :: Point -> SVG
renderTerminal (x,y) =
  Group
    [ Line (x,y) (x+10,y) stroke
    , Circle (x+15,y) 5 stroke FillNone
    ]
