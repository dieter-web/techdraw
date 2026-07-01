{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module TechDraw.SVG.Render
  ( renderSvgDoc,
  )
where

import Data.Text (Text)
import qualified Data.Text as T
import TechDraw.Core.Style
import TechDraw.Core.Types
import TechDraw.SVG.Types

-- ------------------------------------------------------------
-- SvgDoc → Text
-- ------------------------------------------------------------

renderSvgDoc :: SvgDoc -> Text
renderSvgDoc SvgDoc {svgWidth, svgHeight, svgRoot} =
  T.concat
    [ "<svg xmlns=\"http://www.w3.org/2000/svg\" ",
      "width=\"",
      t svgWidth,
      "\" ",
      "height=\"",
      t svgHeight,
      "\">\n",
      T.concat (map renderEntry svgRoot),
      "</svg>\n"
    ]

-- ------------------------------------------------------------
-- Einträge rendern
-- ------------------------------------------------------------

renderEntry :: (Shape, Stroke, Maybe Fill) -> Text
renderEntry (shape, stroke, mfill) =
  case shape of
    SRect (Point x y) w h ->
      T.concat
        [ "<rect x=\"",
          t x,
          "\" y=\"",
          t y,
          "\" width=\"",
          t w,
          "\" height=\"",
          t h,
          "\" ",
          renderStroke stroke,
          renderFill mfill,
          "/>\n"
        ]
    SLine (Point x1 y1) (Point x2 y2) ->
      T.concat
        [ "<line x1=\"",
          t x1,
          "\" y1=\"",
          t y1,
          "\" x2=\"",
          t x2,
          "\" y2=\"",
          t y2,
          "\" ",
          renderStroke stroke,
          "/>\n"
        ]
    SCircle (Point cx cy) r ->
      T.concat
        [ "<circle cx=\"",
          t cx,
          "\" cy=\"",
          t cy,
          "\" r=\"",
          t r,
          "\" ",
          renderStroke stroke,
          renderFill mfill,
          "/>\n"
        ]
    _ ->
      "<!-- Shape not implemented -->\n"

-- ------------------------------------------------------------
-- Stroke / Fill
-- ------------------------------------------------------------

renderStroke :: Stroke -> Text
renderStroke Stroke {strokeColor, strokeWidth} =
  T.concat
    [ "stroke=\"",
      strokeColor,
      "\" ",
      "stroke-width=\"",
      t strokeWidth,
      "\" "
    ]

renderFill :: Maybe Fill -> Text
renderFill Nothing = "fill=\"none\" "
renderFill (Just FillNone) = "fill=\"none\" "
renderFill (Just (FillColor (Named c))) = T.concat ["fill=\"", c, "\" "]
renderFill (Just (FillColor (RGB r g b))) =
  T.concat ["fill=\"rgb(", t r, ",", t g, ",", t b, ")\" "]

-- ------------------------------------------------------------
-- Helper
-- ------------------------------------------------------------

t :: (Show a) => a -> Text
t = T.pack . show
