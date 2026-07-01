module TechDraw.Core.Types
  ( Point (..),
    PathCmd (..),
    Shape (..),
    SvgDocument (..),
    pscale,
    pnormalize,
    portho,
    padd,
    psub,
    plen,
    pdist,
    -- paddv,
    -- psubv,
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Transform

-- import TechDraw.Core.Transform(Transform())

-- data Transform
-- Double  = Translate Double Double
--  | Rotate Double
--  | Scale Double Double
--  deriving (Eq, Show)

-- Basis-Type
data Point = Point
  { px :: Double,
    py :: Double
  }
  deriving (Show, Eq)

-- data Vec = Vec
--  { vx :: !Double,
--    vy :: !Double
--  }
--  deriving (Show, Eq)

data PathCmd
  = M Point -- M
  | L Point -- L
  | H Double -- H
  | V Double -- V
  | C Point Point Point -- C
  | S Point Point -- S
  | Q Point Point -- Q
  | T Point -- T
  | A Double Double Double Bool Bool Point -- A rx ry xrot largeArc sweep
  | Z -- Z
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
  -- SPolygon [Point]
  -- SPolyline [Point]
  -- SCubicBezier Point Point Point Point
  -- SQuadraticBezier Point Point Point
  -- SImage Point Double Double FilePath
  -- SRichText Point TextSyle String
  -- SArrow Point Point ArrowStyle
  -- SLayer String [Shape]
  -- SClip Shape Shape
  -- SMask Shape Shape
  deriving (Show, Eq)

data SvgDocument = SvgDocument
  { svgWidth :: Double,
    svgHeight :: Double,
    svgContent :: [(Shape, Stroke, Maybe Fill)]
  }
  deriving (Eq, Show)

instance Num Point where
  (Point x1 y1) + (Point x2 y2) = Point (x1 + x2) (y1 + y2)
  (Point x1 y1) - (Point x2 y2) = Point (x1 - x2) (y1 - y2)
  (Point x1 y1) * (Point x2 y2) = Point (x1 * x2) (y1 * y2)
  abs (Point x y) = Point (abs x) (abs y)
  signum (Point x y) = Point (signum x) (signum y)
  fromInteger n = Point (fromInteger n) (fromInteger n)

-- Skalierung
pscale :: Double -> Point -> Point
pscale k (Point x y) = Point (k * x) (k * y)

-- Orthogonale Richtung berechnen
pnormalize :: Point -> Point
pnormalize (Point x y) =
  let lens = sqrt (x * x + y * y)
   in Point (x / lens) (y / lens)

portho :: Point -> Point
portho (Point x y) = Point (-y) x

-- dist :: Point -> Point -> Double
-- dist (Point x1 y1) (Point x2 y2) =
--   sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
--
padd :: Point -> Point -> Point
padd (Point x1 y1) (Point x2 y2) = Point (x1 + x2) (y1 + y2)

psub :: Point -> Point -> Point
psub (Point x1 y1) (Point x2 y2) = Point (x1 - x2) (y1 - y2)

plen :: Point -> Double
plen (Point x y) = sqrt (x * x + y * y)

pdist :: Point -> Point -> Double
pdist p1 p2 = plen (psub p2 p1)

-- paddv :: Point -> Vec -> Point
-- paddv (Point x y) (Vec dx dy) = Point (x + dx) (y + dy)

-- psubv :: Point -> Vec -> Point
-- psubv (Point x y) (Vec dx dy) = Point (x - dx) (y - dy)
