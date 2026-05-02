module TechDraw.Pcb.DSL
  ( moduleBox
  , connector
  , mountHole
  , dimension
  , label
  , group
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types
import TechDraw.Pcb.Elements.ModuleBox
import TechDraw.Pcb.Elements.Connector
import TechDraw.Pcb.Elements.MountHole
import TechDraw.Pcb.Elements.Dimension
import TechDraw.Pcb.Elements.Label
import TechDraw.Pcb.Elements.Axes

group :: [TechElement] -> TechElement
group = EGroup

pad :: Point -> Double -> Double -> PadShape -> String -> TechElement
pad = EPad

trace :: [Point] -> Double -> TechElement
trace = ETrace

silkLine :: Point -> Point -> TechElement
silkLine = ESilkLine

silkText :: Point -> String -> TechElement
silkText = ESilkText

silkCircle :: Point -> Double -> TechElement
silkCircle = ESilkCircle
