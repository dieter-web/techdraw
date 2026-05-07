module TechDraw.SVG.Util (
    translate,
    rotateAround,
    scaleUniform,
    scaleXY,
) where

import TechDraw.SVG
import TechDraw.SVG.Types

translate :: Pos -> SVG -> SVG
translate (dx, dy) svg =
    Transform (Translate dx dy) svg

rotateAround :: Double -> Pos -> SVG -> SVG
rotateAround angle center svg =
    Transform (Rotate angle center) svg

scaleUniform :: Double -> SVG -> SVG
scaleUniform s svg =
    Transform (Scale s s) svg

scaleXY :: Double -> Double -> SVG -> SVG
scaleXY sx sy svg =
    Transform (Scale sx sy) svg
