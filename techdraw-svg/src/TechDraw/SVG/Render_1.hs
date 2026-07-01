{-# LANGUAGE OverloadedStrings #-}

module TechDraw.SVG.Render
  ( renderSvgDoc,
    renderShape,
  )
where

import Data.Text (Text)
import qualified Data.Text as T
import TechDraw.Core.Style
import TechDraw.Core.Types
  ( PathCmd (..),
    Point (..),
    Shape (..),
    Transform (..),
  )
import TechDraw.SVG.Types

--------------------------------------------------------------------------------
-- Hilfsfunktionen
--------------------------------------------------------------------------------

tshow :: (Show a) => a -> Text
tshow = T.pack . show

--------------------------------------------------------------------------------
-- SVG-Dokument
--------------------------------------------------------------------------------

renderSvgDoc :: SvgDoc -> Text
renderSvgDoc doc =
  "<svg width=\""
    <> tshow (svgWidth doc)
    <> "\" height=\""
    <> tshow (svgHeight doc)
    <> "\" xmlns=\"http://www.w3.org/2000/svg\">\n"
    <> T.concat (map renderRootItem (svgRoot doc))
    <> "</svg>\n"

renderRootItem :: (Shape, Stroke, Maybe Fill) -> Text
renderRootItem (shape, stroke, mfill) =
  let fill = maybe FillNone id mfill
   in renderShape shape stroke fill

--------------------------------------------------------------------------------
-- Style
--------------------------------------------------------------------------------

renderStyle :: Stroke -> Fill -> Text
renderStyle stroke fill =
  "stroke=\""
    <> strokeColor stroke
    <> "\" stroke-width=\""
    <> tshow (strokeWidth stroke)
    <> "\" fill=\""
    <> renderFill fill
    <> "\""

renderFill :: Fill -> Text
renderFill FillNone = "none"
renderFill (FillColor col) = renderColor col

--------------------------------------------------------------------------------
-- Color
--------------------------------------------------------------------------------

renderColor :: Color -> Text
renderColor (Named name) = name
renderColor (RGB r g b) =
  "rgb(" <> tshow r <> "," <> tshow g <> "," <> tshow b <> ")"

--------------------------------------------------------------------------------
-- Shape → SVG
--------------------------------------------------------------------------------

renderShape :: Shape -> Stroke -> Fill -> Text
renderShape (SLine (Point x1 y1) (Point x2 y2)) stroke fill =
  "<line x1=\""
    <> tshow x1
    <> "\" y1=\""
    <> tshow y1
    <> "\" x2=\""
    <> tshow x2
    <> "\" y2=\""
    <> tshow y2
    <> "\" "
    <> renderStyle stroke fill
    <> " />\n"
renderShape (SRect (Point x y) w h) stroke fill =
  "<rect x=\""
    <> tshow x
    <> "\" y=\""
    <> tshow y
    <> "\" width=\""
    <> tshow w
    <> "\" height=\""
    <> tshow h
    <> "\" "
    <> renderStyle stroke fill
    <> " />\n"
renderShape (SCircle (Point cx cy) r) stroke fill =
  "<circle cx=\""
    <> tshow cx
    <> "\" cy=\""
    <> tshow cy
    <> "\" r=\""
    <> tshow r
    <> "\" "
    <> renderStyle stroke fill
    <> " />\n"
renderShape (SEllipse (Point cx cy) rx ry) stroke fill =
  "<ellipse cx=\""
    <> tshow cx
    <> "\" cy=\""
    <> tshow cy
    <> "\" rx=\""
    <> tshow rx
    <> "\" ry=\""
    <> tshow ry
    <> "\" "
    <> renderStyle stroke fill
    <> " />\n"
renderShape (SText (Point x y) txt) stroke fill =
  "<text x=\""
    <> tshow x
    <> "\" y=\""
    <> tshow y
    <> "\" "
    <> renderStyle stroke fill
    <> "\">"
    <> escapeText txt
    <> "</text>\n"
renderShape (SPath cmds) stroke fill =
  "<path d=\""
    <> renderPath cmds
    <> "\" "
    <> renderStyle stroke fill
    <> " />\n"
renderShape (SArc (Point cx cy) rx ry startA endA) stroke fill =
  let (x1, y1) = arcPoint cx cy rx ry startA
      (x2, y2) = arcPoint cx cy rx ry endA
   in "<path d=\"M "
        <> tshow x1
        <> " "
        <> tshow y1
        <> " A "
        <> tshow rx
        <> " "
        <> tshow ry
        <> " 0 0 1 "
        <> tshow x2
        <> " "
        <> tshow y2
        <> "\" "
        <> renderStyle stroke fill
        <> " />\n"
renderShape (SGroup shapes) stroke fill =
  "<g>\n" <> T.concat (map (\s -> renderShape s stroke fill) shapes) <> "</g>\n"
renderShape (SStyled shape mStroke mFill) stroke fill =
  let stroke' = maybe stroke id mStroke
      fill' = maybe fill id mFill
   in renderShape shape stroke' fill'
renderShape (STransformed shape transforms) stroke fill =
  "<g transform=\""
    <> renderTransforms transforms
    <> "\">\n"
    <> renderShape shape stroke fill
    <> "</g>\n"

--------------------------------------------------------------------------------
-- Path
--------------------------------------------------------------------------------

renderPath :: [PathCmd] -> Text
renderPath = T.intercalate " " . map renderCmd

renderCmd :: PathCmd -> Text
renderCmd (M (Point x y)) = "M " <> tshow x <> " " <> tshow y
renderCmd (L (Point x y)) = "L " <> tshow x <> " " <> tshow y
renderCmd (Q (Point x1 y1) (Point x y)) =
  "Q " <> tshow x1 <> " " <> tshow y1 <> " " <> tshow x <> " " <> tshow y
renderCmd (C (Point x1 y1) (Point x2 y2) (Point x y)) =
  "C "
    <> tshow x1
    <> " "
    <> tshow y1
    <> " "
    <> tshow x2
    <> " "
    <> tshow y2
    <> " "
    <> tshow x
    <> " "
    <> tshow y
renderCmd Z = "Z"

--------------------------------------------------------------------------------
-- Transform
--------------------------------------------------------------------------------

renderTransforms :: [Transform] -> Text
renderTransforms = T.intercalate " " . map renderTransform

renderTransform :: Transform -> Text
renderTransform (Translate dx dy) = "translate(" <> tshow dx <> "," <> tshow dy <> ")"
renderTransform (Rotate a) = "rotate(" <> tshow a <> ")"
renderTransform (Scale sx sy) = "scale(" <> tshow sx <> "," <> tshow sy <> ")"
renderTransform (Matrix a b c d e f) =
  "matrix(" <> T.intercalate "," (map tshow [a, b, c, d, e, f]) <> ")"

--------------------------------------------------------------------------------
-- Text-Escaping
--------------------------------------------------------------------------------

escapeText :: String -> Text
escapeText = T.concat . map escapeChar
  where
    escapeChar '<' = "&lt;"
    escapeChar '>' = "&gt;"
    escapeChar '&' = "&amp;"
    escapeChar c = T.singleton c

--------------------------------------------------------------------------------
-- Arc
--------------------------------------------------------------------------------

arcPoint :: Double -> Double -> Double -> Double -> Double -> (Double, Double)
arcPoint cx cy rx ry angle =
  let rad = angle * pi / 180
   in (cx + rx * cos rad, cy + ry * sin rad)
