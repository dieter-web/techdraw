-- {-# LANGUAGE NamedFieldPuns #-}

module Main where

import qualified Data.Text.IO as T
import TechDraw.Core.Types (Point (..))
import TechDraw.Electrical.Render
import TechDraw.Electrical.Types
  ( Electrical (..),
    ElectricalElement (..),
    Orientation (..),
    Symbol (..),
    Wire (..),
  )
import TechDraw.SVG.Render

-- import TechDraw.SVG.Types (SvgDoc (..))

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
            { elSymbol = Inductor,
              elPosition = Point 80 20,
              elOrientation = Rot0
            }
        ],
      wires =
        [ Wire (Point 20 20) (Point 80 20)
        ]
    }

-- ------------------------------------------------------------
-- Main
-- ------------------------------------------------------------

main :: IO ()
main = do
  let electrical = exampleElectrical
      doc = toSvgDoc 800 600 electrical
      svgText = renderSvgDoc doc

  T.writeFile "schaltplan.svg" svgText

  putStrLn "SVG-Document 'schaltplan.svg' geschrieben."
