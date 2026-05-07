module TechDraw.Electrical.BoundingBox (bboxSymbol) where

import TechDraw.Electrical.Render (renderSym)
import TechDraw.Electrical.Types (Symbol)
import TechDraw.SVG.BoundingBox (BBox, bbox)

bboxSymbol :: Symbol -> BBox
bboxSymbol sym = bbox (renderSym sym)
