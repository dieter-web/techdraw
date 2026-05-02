-- Hilfsfunktionen

module TechDraw.KiCad.Render
  ( kicadGraphicToSVG
  , kicadPointToPoint
  ) where

import TechDraw.SVG
import KiCad.Symbol

kpt :: KiCadPoint -> Point
kpt (KiCadPoint x y) = (x, y)

defaultStroke :: Maybe Stroke
defaultStroke = Just (StrokeColor "black" 0.4)

defaultStroke :: Style
defaultStroke = Stroke 0.4 "black"

kicadPointToPoint :: KiCadPoint -> Point
kicadPointToPoint (KiCadPoint x y) = (x, y)



-- Polyline
kicadGraphicToSVG :: KiCadGraphic -> SVG
kicadGraphicToSVG (GPolyline pts) =
  Polyline (map kicadPointToPoint pts) defaultStroke

-- Circle
kicadGraphicToSVG (GCircle center r) =
  Circle (kicadPointToPoint center) r defaultStroke NoFill

-- Rectangle
kicadGraphicToSVG (GRect p1 p2) =
  Rect (kicadPointToPoint p1) (kicadPointToPoint p2) defaultStroke NoFill

-- Arc(Start-Mid-End->Path)
kicadGraphicToSVG (GArc start mid end) =
  Path
    [ MoveTo (kicadPointToPoint start)
    , ArcTo  (kicadPointToPoint start)
             (kicadPointToPoint mid)
             (kicadPointToPoint end)
    ]
    defaultStroke
    NoFill

-- Text
kicadGraphicToSVG (GText pos _rot txt) =
  Text (kicadPointToPoint pos) txt defaultStroke

-- Pin (Linie + zwei Texte)
kicadGraphicToSVG (GPin pos angle len name num) =
  Group
    [ Line pStart pEnd defaultStroke
    , Text (shiftAlong pEnd (-1.0) angle) name defaultStroke
    , Text (shiftAlong pEnd (-2.0) angle) num  defaultStroke
    ]
  where
    (x0, y0) = kicadPointToPoint pos
    rad      = angle * pi / 180
    dx       = len * cos rad
    dy       = len * sin rad
    pStart   = (x0, y0)
    pEnd     = (x0 + dx, y0 + dy)

    shiftAlong (x,y) d a =
      let r  = a * pi / 180
          dx = d * cos r
          dy = d * sin r
      in (x + dx, y + dy)

-- Komplett: alle Fälle abdecken
kicadGraphicToSVG (GPin pos angle len name num) =
  Group
    [ Line pStart pEnd defaultStroke
    , Text (shiftAlong pEnd (-1.0) angle) name defaultStroke
    , Text (shiftAlong pEnd (-2.0) angle) num  defaultStroke
    ]
  where
    (x0, y0) = kicadPointToPoint pos
    rad      = angle * pi / 180
    dx       = len * cos rad
    dy       = len * sin rad
    pStart   = (x0, y0)
    pEnd     = (x0 + dx, y0 + dy)

    shiftAlong (x,y) d a =
      let r  = a * pi / 180
          dx = d * cos r
          dy = d * sin r
      in (x + dx, y + dy)
