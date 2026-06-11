{-# LANGUAGE NamedFieldPuns #-}

module TechDraw.Electrical.Render
  ( renderElectrical
  , renderElement
  , renderWire
  , toSvgDoc
  ) where 

import TechDraw.SVG.Types
import TechDraw.Core.Types
import TechDraw.Core.Style
import TechDraw.Electrical.Types
--, Transform(..), Style(..)) 

renderElement :: ElectricalElement -> [(Shape, Stroke, Maybe Fill)]
renderElement ElectricalElement {elSymbol, elPosition = Point x y, elOrientation} =
  case elSymbol of
    Resistor -> renderResistor x y elOrientation
    Capacitor -> renderCapacitor x y elOrientation
    Inductor -> renderInductor x y elOrientation


renderElectrical :: Electrical -> [(Shape, Stroke, Maybe Fill)]
renderElectrical (Electrical elems wires) =
  concatMap renderElement elems ++ concatMap renderWire wires

renderResistor :: Double -> Double -> Orientation -> [(Shape, Stroke, Maybe Fill)]
renderResistor x y _ =
  [ ( SLine (Point x y) (Point(x+20) y)
    , defaultStroke 
    , Nothing
    )
  ]

renderCapacitor :: Double -> Double -> Orientation -> [(Shape, Stroke, Maybe Fill)]
renderCapacitor x y _ =
  [ (SLine (Point x y) (Point (x+20) y)
     , defaultStroke
     , Nothing
    )
  ]

renderInductor :: Double -> Double -> Orientation -> [(Shape, Stroke, Maybe Fill)]
renderInductor x y _ =
  [ (SLine (Point x y) (Point (x+20) y)
    , defaultStroke
    , Nothing
    )
  ]
  
renderWire :: Wire -> [(Shape, Stroke, Maybe Fill)]
renderWire Wire {wStart = Point x1 y1, wEnd = Point x2 y2} =
  [ (SLine (Point x1 y1) (Point x2 y2) 
    , defaultStroke
    , Nothing
    )
  ]


toSvgDoc :: Double -> Double -> Electrical -> SvgDoc
toSvgDoc w h electrical = 
  SvgDoc w h (renderElectrical electrical)


