module TechDraw.Pcb.Elements.Connector
  ( connector
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

connector :: Point -> Point -> String -> TechElement
connector = EConnector

