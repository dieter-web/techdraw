module TechDraw.Electrical.Symbols.Lamps
  ( renderLamp
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderLamp :: Point -> SVG
renderLamp (x,y) =
  Group
    [ Circle (x+20,y) 10 (Just (StrokeColor "black" 1)) FillNone
    , Line (x,y) (x+10,y) stroke
    , Line (x+30,y) (x+40,y) stroke
    , Line (x+14,y-6) (x+26,y+6) stroke
    , Line (x+14,y+6) (x+26,y-6) stroke
    ]
