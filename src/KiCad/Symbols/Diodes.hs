module TechDraw.Electrical.Symbols.Diodes
  ( renderDiode
  , renderLED
  , renderZener
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderDiode :: Point -> SVG
renderDiode (x,y) =
  Group
    [ Line (x,y) (x+10,y) stroke
    , Polygon [(x+10,y-10),(x+10,y+10),(x+25,y)] stroke FillNone
    , Line (x+25,y-10) (x+25,y+10) stroke
    , Line (x+25,y) (x+40,y) stroke
    ]

renderLED :: Point -> SVG
renderLED pos =
  Group
    [ renderDiode pos
    , Line (fst pos+30, snd pos-5) (fst pos+40, snd pos-15) stroke
    , Line (fst pos+32, snd pos-5) (fst pos+42, snd pos-15) stroke
    ]

renderZener :: Point -> SVG
renderZener (x,y) =
  Group
    [ Line (x,y) (x+10,y) stroke
    , Polygon [(x+10,y-10),(x+10,y+10),(x+25,y)] stroke FillNone
    , Line (x+25,y-10) (x+30,y+10) stroke
    , Line (x+25,y+10) (x+30,y-10) stroke
    , Line (x+30,y) (x+40,y) stroke
    ]
