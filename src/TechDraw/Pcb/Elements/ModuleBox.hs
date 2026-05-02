module TechDraw.Pcb.Elements.ModuleBox
  ( moduleBox
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

moduleBox :: Point -> Double -> Double -> String -> TechElement
moduleBox = EModuleBox

