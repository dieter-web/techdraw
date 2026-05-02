module TechDraw.Electrical.Symbols.Sources
  ( renderBattery
  , renderDCSource
  , renderACSource
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderBattery :: Point -> SVG
renderBattery (x,y) =
  Group
    [ Line (x,y) (x+10,y) stroke
    , Line (x+10,y-10) (x+10,y+10) stroke
    , Line (x+20,y-6) (x+20,y+6) stroke
    , Line (x+20,y) (x+40,y) stroke
    ]

renderDCSource :: Point -> SVG
renderDCSource (x,y) =
  Group
    [ Line (x,y) (x+40,y) stroke
    , Line (x+20,y-10) (x+20,y+10) stroke
    ]

renderACSource :: Point -> SVG
renderACSource (x,y) =
  Group
    [ Circle (x+20,y) 10 (Just (StrokeColor "black" 1)) FillNone
    , Path [MoveTo (x+10) y, ArcTo 10 10 0 False True (x+30) y] stroke FillNone
    ]
