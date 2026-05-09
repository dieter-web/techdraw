module TechDraw.SVG (
    SVG (..),
    SvgDoc (..),
    Stroke (..),
    TextAnchor (..),
    Color (..),
    Fill (..),
    StrokeStyle (..),
    Point,
    LineCap (..),
    LineJoin (..),
)
where

import TechDraw.SVG.Paths
import TechDraw.SVG.Types (Length, Pos, Transform (..))

type Point = (Double, Double)

-- Konstruktoren
-- z.B. Group :: [SVG] -> SVG ...
data SVG
    = Line Pos Pos (Maybe Stroke)
    | LineStyled Pos Pos StrokeStyle
    | Rect Pos (Double, Double) (Maybe Stroke) Fill
    | RectStyled Pos (Double, Double) StrokeStyle Fill
    | Circle Pos Double (Maybe Stroke) Fill
    | CircleStyled Pos Double StrokeStyle Fill
    | Polyline [Pos] (Maybe Stroke)
    | Polygon [Pos] (Maybe Stroke) Fill
    | Path [PathCommand] (Maybe Stroke) Fill
    | Text Pos TextAnchor String
    | TextStyled Pos TextAnchor String StrokeStyle
    | Group [SVG]
    | Transform Transform SVG
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
    deriving (Eq, Show)

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

data LineCap
    = CapButt
    | CapRound
    | CapSquare
    deriving (Eq, Show)

data LineJoin
    = JoinMiter
    | JoinRound
    | JoinBevel
    deriving (Eq, Show)

data StrokeStyle = StrokeStyle
    { styleColor :: Color
    , styleWidth :: Double
    , styleLineCap :: LineCap
    , styleLineJoin :: LineJoin
    }
    deriving (Show, Eq)
