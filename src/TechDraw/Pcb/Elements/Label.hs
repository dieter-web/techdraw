module TechDraw.Pcb.Elements.Label
  ( label
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

label :: Point -> String -> TechElement
label = ELabel

