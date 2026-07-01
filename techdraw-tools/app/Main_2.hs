{-# LANGUAGE NamedFieldPuns #-}

module Main where

import TechDraw.Core.Style
import TechDraw.Core.Types
  ( PathCmd (..),
    Point (..),
    Shape (..),
    Transform (..),
  )
import TechDraw.Electrical.Types
  ( Electrical (..),
    ElectricalElement (..),
    Orientation (..),
    Symbol (..),
    Wire (..),
  )
import TechDraw.SVG.Types
  ( SvgDoc (..),
  )

-- ------------------------------------------------------------
-- Beispiel: ein kleines Electrical-Modell
-- ------------------------------------------------------------

exampleElectrical :: Electrical
exampleElectrical =
  Electrical
    { elems =
        [ ElectricalElement
            { elSymbol = Resistor,
              elPosition = Point 20 20,
              elOrientation = Rot0
            },
          ElectricalElement
            { elSymbol = Capacitor,
              elPosition = Point 80 20,
              elOrientation = Rot0
            }
        ],
      wires =
        [ Wire (Point 20 20) (Point 80 20)
        ]
    }

-- ------------------------------------------------------------
-- Dummy-Renderer: Electrical -> [(Shape, Stroke, Maybe Fill)]
-- ------------------------------------------------------------

-- Du ersetzt dies später durch dein echtes Render-Modul.
dummyRenderElectrical :: Electrical -> [(Shape, Stroke, Maybe Fill)]
dummyRenderElectrical Electrical {elems, wires} =
  concatMap renderElem elems ++ concatMap renderWire wires
  where
    renderElem ElectricalElement {elPosition = Point x y} =
      [ ( SRect (Point (x - 5) (y - 5)) 10 10,
          defaultStroke,
          Nothing
        )
      ]

    renderWire Wire {wStart, wEnd} =
      [ ( SLine wStart wEnd,
          defaultStroke,
          Nothing
        )
      ]

-- ------------------------------------------------------------
-- SvgDoc erzeugen
-- ------------------------------------------------------------

makeSvg :: Electrical -> SvgDoc
makeSvg e =
  SvgDoc
    { svgWidth = 200,
      svgHeight = 200,
      svgRoot = dummyRenderElectrical e
    }

-- ------------------------------------------------------------
-- Main
-- ------------------------------------------------------------

main :: IO ()
main = do
  let doc = makeSvg exampleElectrical
  putStrLn "SVG-Dokument erzeugt:"
  print doc
