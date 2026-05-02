module TechDraw.SVG.Center
  ( centerSVG
  ) where

import TechDraw.SVG
import TechDraw.SVG.BoundingBox
import TechDraw.SVG.Types

centerSVG :: SVG -> SVG
centerSVG svg =
  let ((minX,minY),(maxX,maxY)) = bbox svg
      cx = (minX + maxX) / 2
      cy = (minY + maxY) / 2
  in Transform [Translate (-cx) (-cy)] svg

