module TechDraw.SVG.Types
  ( Svg (..),
    SvgDoc (..),
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Types

-- | Defined but not used

{-
data SVG
  = Group [(Shape, Stroke, Maybe Fill)]
  | Single (Shape, Stroke, Maybe Fill)
-}

data Svg
  = SvgShape Shape Stroke Fill
  | SvgGroup [Svg]
  deriving (Show, Eq)

data SvgDoc = SvgDoc
  { svgWidth :: Double,
    svgHeight :: Double,
    svgRoot :: [(Shape, Stroke, Maybe Fill)]
  }
  deriving (Show, Eq)
