-- {-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Types
  ( Electrical (..),
    ElectricalElement (..),
    Symbol (..),
    Orientation (..),
    Wire (..),
    NetId (..),
  )
where

import TechDraw.Core.Types (Point)

-- | Orientation of a symbol in degrees.

{-
 - data Orientation
 -   = Deg Double
 -   | Rad Double
 -   deriving (Eq, Show)
 -
 -   oder
 -
 -   newtype Orientation = Orientation Double
 -     deriving(Eq, Show)
 -
 -}
data Orientation
  = Rot0
  | Rot90
  | Rot180
  | Rot270
  deriving (Show, Eq)

orientationToDeg :: Orientation -> Double
orientationToDeg Rot0 = 0
orientationToDeg Rot90 = 90
orientationToDeg Rot180 = 180
orientationToDeg Rot270 = 270

-- | All electrical symbols supported by TechDraw.
data Symbol
  = Resistor
  | ResistorIEC
  | ResistorZigZag
  | Capacitor
  | Inductor
  --  | Switch
  --  | Lamp
  --  | Motor
  --  | Junction
  --  | Diode
  --  | LED
  --  | Switch
  --  | Lamp
  --  | Motor
  --  | JunctionD
  --  | Ground
  --  | VoltageSource
  --  | CurrentSource
  deriving (Show, Eq)

-- | A placed electrical element in a schematic.
data ElectricalElement = ElectricalElement
  { elSymbol :: Symbol,
    elPosition :: Point,
    elOrientation :: Orientation
  }
  deriving (Show, Eq)

data Wire = Wire
  { wStart :: Point,
    wEnd :: Point
  }
  deriving (Show, Eq)

data Electrical = Electrical
  { elems :: [ElectricalElement],
    wires :: [Wire]
  }
  deriving (Show, Eq)

-- | Identifier for a net (electrical connection).
newtype NetId = NetId String
  deriving (Show, Eq)
