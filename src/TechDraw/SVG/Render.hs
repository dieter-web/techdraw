module TechDraw.SVG.Render (
    renderSvgDoc,
    renderSVG,
    renderTransform,
) where

import TechDraw.SVG
import TechDraw.SVG.Matrix
import TechDraw.SVG.Path.Render
import TechDraw.SVG.Paths
import TechDraw.SVG.Style
import TechDraw.SVG.Types

svgHeader :: Double -> Double -> String
svgHeader w h =
    "<svg xmlns=\"http://www.w3.org/2000/svg\" "
        ++ "width=\""
        ++ show w
        ++ "\" "
        ++ "height=\""
        ++ show h
        ++ "\" "
        ++ "viewBox=\"0 0 "
        ++ show w
        ++ " "
        ++ show h
        ++ "\">"

svgFooter :: String
svgFooter = "</svg>"

renderSvgDoc :: SvgDoc -> String
renderSvgDoc (SvgDoc w h root) =
    svgHeader w h ++ renderSVG root ++ svgFooter

renderAttrs :: [(String, String)] -> String
renderAttrs attrs =
    concatMap (\(k, v) -> " " ++ k ++ "=\"" ++ v ++ "\"") attrs

renderStroke :: Stroke -> String
renderStroke (StrokeColor color width) =
    "stroke=\"" ++ color ++ "\" stroke-width=\"" ++ show width ++ "\""
renderStroke (StrokeRGB r g b width) =
    "stroke=\"rgb(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")\" stroke-width=\"" ++ show width ++ "\""

renderMaybeStroke :: Maybe Stroke -> String
renderMaybeStroke Nothing = "stroke=\"none\""
renderMaybeStroke (Just s) = renderStroke s

renderFill :: Fill -> String
renderFill FillNone = "fill=\"none\""
renderFill (FillColor c) = "fill=\"" ++ c ++ "\""

------------------
-- renderTransform
------------------
renderTransform :: Transform -> String
renderTransform (Translate dx dy) =
    "translate(" ++ show dx ++ "," ++ show dy ++ ")"
renderTransform (Rotate a (cx, cy)) =
    "rotate(" ++ show a ++ "," ++ show cx ++ "," ++ show cy ++ ")"
renderTransform (Scale sx sy) =
    "scale(" ++ show sx ++ "," ++ show sy ++ ")"
renderTransform (TransformList ts) =
    unwords (map renderTransform ts)

------------
-- renderSVG
------------

renderSVG :: SVG -> String
renderSVG (Line (x1, y1) (x2, y2) stroke) =
    "<line x1=\""
        ++ show x1
        ++ "\" y1=\""
        ++ show y1
        ++ "\" x2=\""
        ++ show x2
        ++ "\" y2=\""
        ++ show y2
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " />\n"
renderSVG (Rect (x, y) (w, h) stroke fill) =
    "<rect x=\""
        ++ show x
        ++ "\" y=\""
        ++ show y
        ++ "\" width=\""
        ++ show w
        ++ "\" height=\""
        ++ show h
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " "
        ++ renderFill fill
        ++ " />\n"
renderSVG (Circle (x, y) r stroke fill) =
    "<circle cx=\""
        ++ show x
        ++ "\" cy=\""
        ++ show y
        ++ "\" r=\""
        ++ show r
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " "
        ++ renderFill fill
        ++ " />\n"
renderSVG (Polyline pts stroke) =
    "<polyline points=\""
        ++ unwords [show x ++ "," ++ show y | (x, y) <- pts]
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " fill=\"none\" />\n"
renderSVG (Polygon pts stroke fill) =
    "<polygon points=\""
        ++ unwords [show x ++ "," ++ show y | (x, y) <- pts]
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " "
        ++ renderFill fill
        ++ " />\n"
renderSVG (Path cmds stroke fill) =
    "<path d=\""
        ++ unwords (map renderPathCommand cmds)
        ++ "\" "
        ++ renderMaybeStroke stroke
        ++ " "
        ++ renderFill fill
        ++ " />\n"
renderSVG (Text (x, y) anchor content) =
    "<text text-anchor=\""
        ++ show anchor
        ++ "\" x=\""
        ++ show x
        ++ "\" y=\""
        ++ show y
        ++ "\">"
        ++ content
        ++ "</text>\n"
renderSVG (Group xs) =
    concatMap renderSVG xs
-- renderSVG (Transform tr svg) =
----  "<g transform=\"" ++ renderTransform tr ++ "\">\n"
--  "<g transform=\"" ++ toSvgMatrix (toMat3 tr) ++ "\">\n"
--  ++ renderSVG svg ++ "</g>\n"
--
--
-- renderSVG (Transform trs svg) =
--    "<g transform=\"" ++ toSvgMatrix (combineTransforms trs) ++ "\">\n"
--
renderSVG (Transform tr svg) =
    "<g transform=\""
        ++ renderTransform tr
        ++ "\">\n"
        ++ renderSVG svg
        ++ "</g>\n"
renderSVG (LineStyled p1 p2 style) =
    renderSVG (Line p1 p2 (Just (toStroke style)))
renderSVG (RectStyled pos size style fill) =
    renderSVG (Rect pos size (Just (toStroke style)) fill)
renderSVG (CircleStyled pos r style fill) =
    renderSVG (Circle pos r (Just (toStroke style)) fill)
renderSVG (TextStyled pos anchor str style) =
    renderSVG (Text pos anchor str) -- Text hat keinen Stroke im SVG
