module TechDraw.Core.Types
  ( Point (..),
    PathCmd (..),
    Vec,
    Transform (..),
    Shape (..),
    scale,
    normalize,
    ortho,
    add,
    sub,
    len,
    dist,
    addv,
    subv,
  )
where

import TechDraw.Core.Style

-- Basis-Type
data Point = Point
  { px :: Double,
    py :: Double
  }
  deriving (Show, Eq)

data Vec = Vec
  { vx :: !Double,
    vy :: !Double
  }
  deriving (Show, Eq)

-- Atomare Path-Kommandos
data PathCmd
  = M Point -- MoveTo
  | L Point -- LineTo
  | C Point Point Point -- Cubic Bézier
  | Q Point Point -- Quadratic Bézier
  | Z -- ClosePath
  deriving (Show, Eq)

-- Transformationen
data Transform
  = Translate Double Double
  | Rotate Double
  | Scale Double Double
  | Matrix Double Double Double Double Double Double
  deriving (Show, Eq)

--  Geometrische Shapes -- Shape AST
data Shape
  = SPath [PathCmd]
  | SArc Point Double Double Double Double -- center, radiusX, radiusY, startA, endA
  | SLine Point Point
  | SRect Point Double Double
  | SCircle Point Double
  | SEllipse Point Double Double
  | SText Point String
  | SGroup [Shape]
  | SStyled Shape (Maybe Stroke) (Maybe Fill)
  | STransformed Shape [Transform]
  deriving (Show, Eq)

instance Num Point where
  (Point x1 y1) + (Point x2 y2) = Point (x1 + x2) (y1 + y2)
  (Point x1 y1) - (Point x2 y2) = Point (x1 - x2) (y1 - y2)
  (Point x1 y1) * (Point x2 y2) = Point (x1 * x2) (y1 * y2)
  abs (Point x y) = Point (abs x) (abs y)
  signum (Point x y) = Point (signum x) (signum y)
  fromInteger n = Point (fromInteger n) (fromInteger n)

-- Skalierung
scale :: Double -> Point -> Point
scale k (Point x y) = Point (k * x) (k * y)

-- Orthogonale Richtung berechnen
normalize :: Point -> Point
normalize (Point x y) =
  let lens = sqrt (x * x + y * y)
   in Point (x / lens) (y / lens)

ortho :: Point -> Point
ortho (Point x y) = Point (-y) x

-- dist :: Point -> Point -> Double
-- dist (Point x1 y1) (Point x2 y2) =
--   sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
--
add :: Point -> Point -> Point
add (Point x1 y1) (Point x2 y2) = Point (x1 + x2) (y1 + y2)

sub :: Point -> Point -> Point
sub (Point x1 y1) (Point x2 y2) = Point (x1 - x2) (y1 - y2)

len :: Point -> Double
len (Point x y) = sqrt (x * x + y * y)

dist :: Point -> Point -> Double
dist p1 p2 = len (sub p2 p1)

addv :: Point -> Vec -> Point
addv (Point x y) (Vec dx dy) = Point (x + dx) (y + dy)

subv :: Point -> Vec -> Point
subv (Point x y) (Vec dx dy) = Point (x - dx) (y - dy)
