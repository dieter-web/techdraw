{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Ports
  ( Port (..),
    PortId,
    Direction,
    portsOf,
    translatePort,
    rotatePort,
    transformPort,
    portsResistor,
    portsCapacitor,
    portsInductor,
  )
where

import TechDraw.Core.Types (Point (..))
import TechDraw.Electrical.Types (Symbol (..))

-- | A port has an ID, a position, and a direction (in degrees).
type PortId = String

type Direction = Double

data Port = Port
  { portId :: PortId,
    portPos :: Point,
    portDir :: Direction
  }
  deriving (Show, Eq)

--------------------------------------------------------------------------------
-- Transformation helpers
--------------------------------------------------------------------------------

translatePort :: (Double, Double) -> Port -> Port
translatePort (dx, dy) (Port pid (Point x y) d) =
  Port pid (Point (x + dx) (y + dy)) d

rotatePort :: Double -> Port -> Port
rotatePort angle (Port pid (Point x y) d) =
  let rad = angle * pi / 180
      x' = x * cos rad - y * sin rad
      y' = x * sin rad + y * cos rad
   in Port pid (Point x' y') (d + angle)

transformPort :: (Double, Double) -> Double -> Port -> Port
transformPort translation angle =
  rotatePort angle . translatePort translation

--------------------------------------------------------------------------------
-- Symbol-specific port definitions
--------------------------------------------------------------------------------

-- Resistor: 60 units wide, ports left and right
portsResistor :: [Port]
portsResistor =
  [ Port "A" (Point 0 0) 180,
    Port "B" (Point 60 0) 0
  ]

-- Capacitor: 40 units wide, plates at 0 and 40
portsCapacitor :: [Port]
portsCapacitor =
  [ Port "A" (Point 0 0) 180,
    Port "B" (Point 40 0) 0
  ]

-- Inductor: 60 units wide, ports left and right
portsInductor :: [Port]
portsInductor =
  [ Port "A" (Point 0 0) 180,
    Port "B" (Point 60 0) 0
  ]

--------------------------------------------------------------------------------
-- Main dispatcher
--------------------------------------------------------------------------------

portsOf :: Symbol -> [Port]
portsOf sym =
  case sym of
    Resistor -> portsResistor
    Capacitor -> portsCapacitor
    Inductor -> portsInductor

-- weitere Symbole folgen hier

