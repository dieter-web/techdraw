module TechDraw.SVG.Types
  ( Svg (..),
  --    SvgDoc (..),
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Types

data Svg
  = SvgShape Shape Stroke Fill
  | SvgGroup [Svg]
  deriving (Show, Eq)

{-
data SvgDoc = SvgDoc
  { svgWidth :: Double,
    svgHeight :: Double,
    svgRoot :: [(Shape, Stroke, Maybe Fill)]
  }
  deriving (Show, Eq)
  -}
