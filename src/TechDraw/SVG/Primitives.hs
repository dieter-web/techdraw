module TechDraw.SVG.Primitives (
    lineStyled,
)
where

import TechDraw.SVG
import TechDraw.SVG.Types

lineStyled :: Pos -> Pos -> StrokeStyle -> SVG
lineStyled = LineStyled

rectStyled :: Pos -> (Double, Double) -> StrokeStyle -> Fill -> SVG
rectStyled = RectStyled

circleStyled :: Pos -> Double -> StrokeStyle -> Fill -> SVG
circleStyled = CircleStyled

textStyled :: Pos -> TextAnchor -> String -> StrokeStyle -> SVG
textStyled = TextStyled
