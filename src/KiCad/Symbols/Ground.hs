module TechDraw.Electrical.Symbols.Ground
  ( renderGround
  , renderEarthProtective
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderGround :: Point -> SVG
renderGround (x,y) =
  Group
    [ Line (x,y) (x,y+10) stroke
    , Line (x-10,y+10) (x+10,y+10) stroke
    , Line (x-6,y+14) (x+6,y+14) stroke
    , Line (x-3,y+18) (x+3,y+18) stroke
    ]

renderEarthProtective :: Point -> SVG
renderEarthProtective (x,y) =
  Group
    [ Line (x,y) (x,y+12) stroke
    , Line (x-6,y+12) (x+6,y+12) stroke
    , Line (x-4,y+16) (x+4,y+16) stroke
    , Line (x-2,y+20) (x+2,y+20) stroke
    ]
