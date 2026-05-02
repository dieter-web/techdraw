module TechDraw.Pcb.Elements.Axes
  ( axes
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

axes :: Point -> Double -> TechElement
axes origin len =
  EGroup
    [ EDimension origin (Point (px origin + len) (py origin)) "X"
    , EDimension origin (Point (px origin) (py origin + len)) "Y"
    ]

