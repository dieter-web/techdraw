{-# LANGUAGE NamedFieldPuns #-}

-- {-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Render
  ( renderElectrical,
    renderElem,
    renderWire,
    toSvgDoc,
  )
where

-- import Data.Text (Text)
-- import qualified Data.Text as T

import TechDraw.Core.Style
import TechDraw.Core.Types
import TechDraw.Electrical.Types
import TechDraw.SVG.Types

renderElectrical :: Electrical -> [(Shape, Stroke, Maybe Fill)]
renderElectrical (Electrical elems wires) =
  concatMap renderElem elems
    <> concatMap renderWire wires

---------------------
-- Symbole als Shapes
---------------------

renderElem :: ElectricalElement -> [(Shape, Stroke, Maybe Fill)]
renderElem ElectricalElement {elSymbol, elPosition = Point x y} =
  case elSymbol of
    Resistor -> [rect 12 6] -- TODO: Ergänzen zum Widerstand
    Capacitor -> [rect 8 12]
    Inductor -> [circle 6]
  where
    rect w h =
      ( SRect (Point (x - w / 2) (y - h / 2)) w h,
        defaultStroke,
        Just defaultFill
      )
    circle r =
      ( SCircle (Point x y) r,
        defaultStroke,
        Just defaultFill
      )

--------------------------------------------

renderWire :: Wire -> [(Shape, Stroke, Maybe Fill)]
renderWire Wire {wStart = Point x1 y1, wEnd = Point x2 y2} =
  [ ( SLine (Point x1 y1) (Point x2 y2),
      defaultStroke,
      Nothing
    )
  ]

toSvgDoc :: Double -> Double -> Electrical -> SvgDoc
toSvgDoc w h electrical =
  SvgDoc w h (renderElectrical electrical)
