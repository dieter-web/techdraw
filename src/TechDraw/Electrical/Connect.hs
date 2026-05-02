-- file: src/TechDraw/Electrical/Connect.hs
module TechDraw.Electrical.Connect
  ( connect
  , connectManhattan
  ) where

import TechDraw.Electrical.Types
import TechDraw.Electrical.Ports
import TechDraw.Electrical.Routing

connect :: Symbol -> PortName -> Symbol -> PortName -> Wire
connect s1 p1 s2 p2 =
  let pos1 = findPort s1 p1
      pos2 = findPort s2 p2
  in Wire [pos1, pos2]

connectManhattan :: Symbol -> PortName -> Symbol -> PortName -> Wire
connectManhattan s1 p1 s2 p2 =
  let pos1 = findPort s1 p1
      pos2 = findPort s2 p2
  in manhattanWire pos1 pos2

findPort :: Symbol -> PortName -> Pos
findPort sym name =
  case [ portPos p | p <- portsOfSymbol sym, portName p == name ] of
    (p:_) -> p
    []    -> error ("Port not found: " ++ name)
