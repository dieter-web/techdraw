module TechDraw.Pcb.Elements.Dimension
  ( dimension
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

dimension :: Point -> Point -> String -> TechElement
dimension = EDimension

