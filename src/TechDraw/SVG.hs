module TechDraw.SVG
  ( SVG(..)
  , SvgDoc(..)
  , Stroke(..)
  , TextAnchor(..)
  , Color(..)
  , Fill(..)
  , StrokeStyle(..)
  , Transform(..)
  )
  where

import TechDraw.SVG.Types
import TechDraw.SVG.Path

-- Konstruktoren
-- z.B. Group :: [SVG] -> SVG ...
data SVG
  = Line Pos Pos (Maybe Stroke)
  | Rect Pos (Double, Double) (Maybe Stroke) Fill
  | Circle Pos Double (Maybe Stroke) Fill
  | Polyline [Pos] (Maybe Stroke)
  | Polygon [Pos] (Maybe Stroke) Fill
  | Path [PathCommand] (Maybe Stroke) Fill
  | Text Pos TextAnchor String
  | Group [SVG]
--  | Transform Transform SVG
  | Transform [Transform] SVG
  deriving (Show, Eq)

data SvgDoc = SvgDoc
  { svgWidth :: Length
  , svgHeight :: Length
  , svgRoot :: SVG
  }
  deriving (Show, Eq)

data Stroke
  = StrokeColor String Double
  | StrokeRGB Int Int Int Double
  deriving(Eq, Show)

data TextAnchor = AnchorStart | AnchorMiddle | AnchorEnd
  deriving (Show, Eq)

data Color
  = RGB Int Int Int
  | Named String
  deriving (Show, Eq)

data Fill
  = FillColor String
  | FillNone
  deriving (Show, Eq)


data StrokeStyle = StrokeStyle
  { strokeColor :: String
  , strokeWidth :: Double
  , fillColor :: String
  , fontSize :: Double
  }
  deriving (Show, Eq)


-- Scale sx sy für nicht-uniforme Skalierung
-- Scale s s für uniformes Skalieren

data Transform
  = Translate Double Double
  | Rotate Double Pos
  | Scale Double Double
  deriving (Show, Eq)
