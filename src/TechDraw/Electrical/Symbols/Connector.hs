-- file: src/TechDraw/Electrical/Symbols/Connector.hs
module TechDraw.Electrical.Symbols.Connector
  ( renderConnector
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)


renderConnector :: Pos -> SVG
renderConnector (x, y) =
  Group
    [ Circle (x, y) 3 stroke FillNone
    , Line (x-12, y) (x-3, y) stroke
    , Line (x+3,  y) (x+12, y) stroke
    ]
