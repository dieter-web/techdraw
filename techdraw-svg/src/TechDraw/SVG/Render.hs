{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module TechDraw.SVG.Render
  ( renderSvgDoc,
    renderShape,
    renderPath,
    renderCmd,
  )
where

import Data.Text (Text)
import qualified Data.Text as T
import TechDraw.Core.Style
import TechDraw.Core.Transform
import TechDraw.Core.Types
import TechDraw.SVG.Types

-- ------------------------------------------------------------
-- SVG-Dokument rendern
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

renderEntry :: (Shape, Stroke, Maybe Fill) -> Text
renderEntry (shape, stroke, mfill) =
  renderShape shape stroke mfill

-- ------------------------------------------------------------
-- Alle Shapes rendern
-- ------------------------------------------------------------

renderShape :: Shape -> Stroke -> Maybe Fill -> Text
renderShape shape stroke mfill =
  case shape of
    -- --------------------------------------------------------
    -- PATH
    -- --------------------------------------------------------
    SPath cmds ->
      T.concat
        [ "<path d=\"",
          renderPath cmds,
          "\" ",
          renderStroke stroke,
          renderFill mfill,
          "/>\n"
        ]
    -- --------------------------------------------------------
    -- ARC (SVG arc command)
    -- --------------------------------------------------------
    SArc (Point cx cy) rx ry startA endA ->
      let (sx, sy) = arcPoint cx cy rx ry startA
          (ex, ey) = arcPoint cx cy rx ry endA
          largeArc = if abs (endA - startA) > pi then "1" else "0"
          sweep = if endA > startA then "1" else "0"
       in T.concat
            [ "<path d=\"M ",
              t sx,
              " ",
              t sy,
              " A ",
              t rx,
              " ",
              t ry,
              " 0 ",
              largeArc,
              " ",
              sweep,
              " ",
              t ex,
              " ",
              t ey,
              "\" ",
              renderStroke stroke,
              renderFill mfill,
              "/>\n"
            ]
    -- --------------------------------------------------------
    -- LINE
    -- --------------------------------------------------------
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
    -- --------------------------------------------------------
    -- RECT
    -- --------------------------------------------------------
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
    -- --------------------------------------------------------
    -- CIRCLE
    -- --------------------------------------------------------
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
    -- --------------------------------------------------------
    -- ELLIPSE
    -- --------------------------------------------------------
    SEllipse (Point cx cy) rx ry ->
      T.concat
        [ "<ellipse cx=\"",
          t cx,
          "\" cy=\"",
          t cy,
          "\" rx=\"",
          t rx,
          "\" ry=\"",
          t ry,
          "\" ",
          renderStroke stroke,
          renderFill mfill,
          "/>\n"
        ]
    -- --------------------------------------------------------
    -- TEXT
    -- --------------------------------------------------------
    SText (Point x y) txt ->
      T.concat
        [ "<text x=\"",
          t x,
          "\" y=\"",
          t y,
          "\" ",
          renderStroke stroke,
          renderFill mfill,
          ">",
          escape txt,
          "</text>\n"
        ]
    -- --------------------------------------------------------
    -- GROUP
    -- --------------------------------------------------------
    SGroup shapes ->
      T.concat
        [ "<g>\n",
          T.concat [renderShape s stroke mfill | s <- shapes],
          "</g>\n"
        ]
    -- --------------------------------------------------------
    -- STYLED
    -- --------------------------------------------------------
    SStyled inner mStroke mFill ->
      let stroke' = maybe stroke id mStroke
          fill' = maybe mfill Just mFill
       in renderShape inner stroke' fill'
    -- --------------------------------------------------------
    -- TRANSFORMED
    -- --------------------------------------------------------
    STransformed inner transforms ->
      T.concat
        [ "<g transform=\"",
          renderTransforms transforms,
          "\">\n",
          renderShape inner stroke mfill,
          "</g>\n"
        ]

-- ------------------------------------------------------------
-- PathCmd → SVG path data
-- ------------------------------------------------------------

renderPath :: [PathCmd] -> Text
renderPath = T.concat . map renderCmd

renderCmd :: PathCmd -> Text
renderCmd (M (Point x y)) =
  T.concat ["M ", t x, " ", t y, " "]
renderCmd (L (Point x y)) =
  T.concat ["L ", t x, " ", t y, " "]
renderCmd (H x) =
  T.concat ["H ", t x, " "]
renderCmd (V x) =
  T.concat ["V ", t x, " "]
renderCmd (C (Point x1 y1) (Point x2 y2) (Point x y)) =
  T.concat ["C ", t x1, " ", t y1, " ", t x2, " ", t y2, " ", t x, " ", t y, " "]
renderCmd (S (Point x2 y2) (Point x y)) =
  T.concat ["S ", t x2, " ", t y2, " ", t x, " ", t y, " "]
renderCmd (Q (Point cx cy) (Point x y)) =
  T.concat ["Q ", t cx, " ", t cy, " ", t x, " ", t y, " "]
renderCmd (T (Point x y)) =
  T.concat ["T ", t x, " ", t y, " "]
renderCmd (A rx ry rot large sweep (Point x y)) =
  T.concat
    [ "A ",
      t rx,
      " ",
      t ry,
      " ",
      t rot,
      " ",
      boolFlag large,
      " ",
      boolFlag sweep,
      " ",
      t x,
      " ",
      t y,
      " "
    ]
renderCmd Z = "Z "

boolFlag :: Bool -> Text
boolFlag True = "1"
boolFlag False = "0"

-- ------------------------------------------------------------
-- Transform → SVG transform attribute
-- ------------------------------------------------------------

renderTransforms :: [Transform] -> Text
renderTransforms = T.intercalate " " . map renderT
  where
    renderT (Translate dx dy) = T.concat ["translate(", t dx, ",", t dy, ")"]
    renderT (Rotate a) = T.concat ["rotate(", t a, ")"]
    renderT (Scale sx sy) = T.concat ["scale(", t sx, ",", t sy, ")"]

--    renderT (Matrix6 a b c d e f) =
--      T.concat ["matrix(", t a, ",", t b, ",", t c, ",", t d, ",", t e, ",", t f, ")"]

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

escape :: String -> Text
escape = T.pack

arcPoint :: Double -> Double -> Double -> Double -> Double -> (Double, Double)
arcPoint cx cy rx ry a =
  (cx + rx * cos a, cy + ry * sin a)
