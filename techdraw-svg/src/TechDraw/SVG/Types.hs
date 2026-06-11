module TechDraw.SVG.Types
  ( Shape(..) 
  , Fill(..)
  , SvgDoc(..)
  ) where

import TechDraw.Core.Types
import TechDraw.Core.Style

-- | Defined but not used 
{-
data SVG 
  = Group [(Shape, Stroke, Maybe Fill)]
  | Single (Shape, Stroke, Maybe Fill)
-}

data SvgDoc = SvgDoc
  { svgWidth :: Double
  , svgHeight :: Double
  , svgRoot :: [(Shape, Stroke, Maybe Fill)]
  } deriving (Show, Eq)
