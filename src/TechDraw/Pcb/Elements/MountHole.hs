module TechDraw.Pcb.Elements.MountHole
  ( mountHole
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

mountHole :: Point -> Double -> TechElement
mountHole = EMountHole

