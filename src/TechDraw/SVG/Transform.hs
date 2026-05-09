module TechDraw.SVG.Transform (
    translate,
    rotate,
    scale,
    rotateAround,
    scaleUniform,
    scaleXY,
) where

import TechDraw.SVG
import TechDraw.SVG.Types

translate :: Pos -> SVG -> SVG
translate (dx, dy) = Transform (Translate dx dy)

rotate :: Double -> SVG -> SVG
rotate a = Transform (Rotate a (0, 0))

scale :: Double -> SVG -> SVG
scale s = Transform (Scale s s)

rotateAround :: Double -> Pos -> SVG -> SVG
rotateAround a p = Transform (Rotate a p)

scaleUniform :: Double -> SVG -> SVG
scaleUniform s = Transform (Scale s s)

scaleXY :: Double -> Double -> SVG -> SVG
scaleXY sx sy = Transform (Scale sx sy)
