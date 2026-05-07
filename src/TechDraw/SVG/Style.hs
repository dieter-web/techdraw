module TechDraw.SVG.Style (
    toStroke,
) where

import TechDraw.SVG

toStroke :: StrokeStyle -> Stroke
toStroke s =
    case styleColor s of
        Named name -> StrokeColor name (styleWidth s)
        RGB r g b -> StrokeRGB r g b (styleWidth s)
