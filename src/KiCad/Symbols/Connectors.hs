module TechDraw.Electrical.Symbols.Connectors
  ( renderConnector
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderConnector :: Point -> SVG
renderConnector (x,y) =
  Group
    [ Rect (x,y-5) (20,10) stroke FillNone
    , Line (x+20,y) (x+30,y) stroke
    ]
