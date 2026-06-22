{-# LANGUAGE OverloadedStrings #-}

module TechDraw.SVG.Render
  ( renderSvg,
    renderCmd,
  )
where

import Data.Text (Text, pack)
import qualified Data.Text as T
-- import Prelude hiding (map)
-- import qualified Prelude as P

-- import TechDraw.Core.Path
import TechDraw.Core.Style
import TechDraw.Core.Types
import TechDraw.SVG.Types

renderPoint :: Point -> Text
renderPoint (Point x y) = T.pack (show x) <> "," <> T.pack (show y)

renderCmd :: PathCmd -> Text
renderCmd (M p) = "M " <> renderPoint p -- MoveTo: M, m
renderCmd (L p) = "L " <> renderPoint p -- LineTo: L, l, H, h, V, v
renderCmd (Q c p) = "Q " <> renderPoint c <> " " <> renderPoint p -- Quadratic Bézier curve: Q, q, T, t
renderCmd (C a b p) = "C " <> renderPoint a <> " " <> renderPoint b <> " " <> renderPoint p -- Cubic Bézhier curve: C, c, S, s
-- Elliptical arc curve: A,a
renderCmd Z = "Z" -- ClosePath: Z, z

{-
renderStyle :: Style -> Text
renderStyle s =
  let strokeTxt = case styleStroke s of
        Nothing -> "stroke:none"
        Just (Stroke col w) ->
          "stroke:" <> col <> ";stroke-width:" <> T.pack (show w)
      fillTxt = case styleFill s of
        Nothing -> "fill:none"
        Just (Fill col) -> "fill:" <> col
  in strokeTxt <> ";" <> fillTxt
-}

svgWrap :: Text -> Text
svgWrap body =
  "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"200\" height=\"200\">" <> body <> "</svg>"

{-
renderStroke :: Stroke -> String
renderStroke s =
  " stroke=\"" ++ show (strokeColor s) ++ "\" stroke-width=\"" ++ show (strokeWidth s) ++ "\""
-}
-- Helpers
renderStroke :: Stroke -> Text
renderStroke (Stroke color width) =
  "stroke=\"" <> color <> "\" stroke-width=\"" <> pack (show width) <> "\""

renderFill :: Fill -> Text
renderFill FillNone =
  "fill=\"none\""
renderFill (FillColor color) =
  "fill=\"" <> color <> "\""

t :: Double -> Text
t = T.pack . show

{-
renderShape :: (Shape, Stroke, Maybe Fill) -> String

-- ARC ------------------------------------------------------
renderShape (SArc (Point cx cy) rx ry start end, stroke, mfill) =
  let
    s = start * pi / 180
    e = end   * pi / 180

    x1 = cx + rx * cos s
    y1 = cy + ry * sin s

    x2 = cx + rx * cos e
    y2 = cy + ry * sin e

    largeArc = abs (end - start) > 180
    sweep    = end > start

    strokeAttr = renderStroke stroke
    fillAttr   = maybe "fill=\"none\"" (\(Fill c) -> "fill=\"" ++ T.unpack c ++ "\"") mfill
  in
    "<path d=\"M "
    ++ show x1 ++ " " ++ show y1
    ++ " A "
    ++ show rx ++ " " ++ show ry ++ " 0 "
    ++ (if largeArc then "1 " else "0 ")
    ++ (if sweep    then "1 " else "0 ")
    ++ show x2 ++ " " ++ show y2
    ++ "\" "
    ++ strokeAttr ++ " "
    ++ fillAttr
    ++ "/>"

-- LINE -----------------------------------------------------
renderShape (SLine p1 p2, stroke, mfill) =
  "<line x1=\"" ++ show (px p1) ++ "\" y1=\"" ++ show (py p1)
  ++ "\" x2=\"" ++ show (px p2) ++ "\" y2=\"" ++ show (py p2)
  ++ "\" " ++ renderStroke stroke ++ " "
  ++ maybe "fill=\"none\"" (\(Fill c) -> "fill=\"" ++ T.unpack c ++ "\"") mfill
  ++ "/>"
  where
    px (Point x _) = x
    py (Point _ y) = y

-- RECT -----------------------------------------------------
renderShape (SRect (Point x y) w h, stroke, mfill) =
  "<rect x=\"" ++ show x ++ "\" y=\"" ++ show y
  ++ "\" width=\"" ++ show w ++ "\" height=\"" ++ show h
  ++ "\" " ++ renderStroke stroke ++ " "
  ++ maybe "fill=\"none\"" (\(Fill c) -> "fill=\"" ++ T.unpack c ++ "\"") mfill
  ++ "/>"

-- CIRCLE ---------------------------------------------------
renderShape (SCircle (Point cx cy) r, stroke, mfill) =
  "<circle cx=\"" ++ show cx ++ "\" cy=\"" ++ show cy
  ++ "\" r=\"" ++ show r
  ++ "\" " ++ renderStroke stroke ++ " "
  ++ maybe "fill=\"none\"" (\(Fill c) -> "fill=\"" ++ T.unpack c ++ "\"") mfill
  ++ "/>"

----------
-- PATH --
-- -------
renderShape (SPath cmds, stroke, mfill) =
  "TODO: schreiben\n"

  "<path d=\"" ++ T.unpack (renderPath (SPath cmds))
  ++ "\" " ++ renderStroke stroke ++ " "
  ++ maybe "fill=\"none\"" (\(Fill c) -> "fill=\"" ++ T.unpack c ++ "\"") mfill
  ++ "/>"

----------
-- GROUP -
----------
renderShape (SGroup shapes, stroke, mfill) =
  "<g>"
  ++ concatMap (\sh -> renderShape (sh, stroke, mfill)) shapes
  ++ "</g>"

----------
-- ELLIPSE
-- -------
renderShape ( SEllipse {}, _, _) =
  "<g>"
  ++ "</g>"

-------
-- TEXT
-- ----
renderShape (SText {}, _, _) =
  "<g>"
  ++ "</g>"

----------
-- SStyled
-- -------
renderShape ( SStyled {}, _, _) =
  "<g>"
  ++ "</g>"

---------------
-- STransformed
-- ------------
renderShape ( STransformed {}, _, _) =
  "<g>"
  ++ "</g>"
  -}

-- Render Svg elements
renderSvg :: Svg -> Text
renderSvg (SvgPath cmds stroke fill) =
  "<path d=\""
    <> T.intercalate " " (map renderCmd cmds)
    <> "\""
    <> renderStroke stroke
    <> " "
    <> renderFill fill
    <> "/>"
renderSvg (SvgCircle x y r stroke fill) =
  "<circle cx=\""
    <> t x
    <> "\" cy=\""
    <> t y
    <> "\" r=\""
    <> t r
    <> "\" "
    <> renderStroke stroke
    <> " "
    <> renderFill fill
    <> "/>"
renderSvg (SvgRect x y w h stroke fill) =
  "<rect x=\""
    <> t x
    <> "\" y=\""
    <> t y
    <> "\" "
    <> "width=\""
    <> t w
    <> "\" height=\""
    <> t h
    <> "\" "
    <> renderStroke stroke
    <> " "
    <> renderFill fill
    <> "/>"
