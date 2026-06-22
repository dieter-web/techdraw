-- Das ist die klassische FP-Architektur: Core -> Convert -> Svg -> Render
--
module TechDraw.Convert.ShapeToSvg
  ( shapeToSvg,
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Types
import TechDraw.SVG.Types

-- defaultStroke :: Stroke
-- defaultStroke = StrokeColor "black"

-- defaultFill :: Fill
-- defaultFill = FillNone
{-
Diagnostics:
1. Pattern match(es) are non-exhaustive
   In an equation for ‘shapeToSvg’:
       Patterns of type ‘Shape’ not matched:
           SArc _ _ _ _ _
           SEllipse _ _ _
           SText _ _
           SGroup _
           ... [-Wincomplete-patterns]
2. Variable not in scope: defaultFill :: Fill [-Wdeferred-out-of-scope-variables].
-}
shapeToSvg :: Shape -> Svg
shapeToSvg sh =
  SvgShape sh defaultStroke defaultFill
shapeToSvg (SGroup xs) =
  SvgGroup (map shapeToSvg xs)
