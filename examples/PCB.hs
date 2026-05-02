module Main where

import TechDraw
import TechDraw.Types
import TechDraw.Export.SVG (renderSVG)
import System.IO (writeFile)

pcb :: [TechElement]
pcb =
  [ -- PCB-Umriss
    moduleBox (Point (-50) (-30)) 100 60 "PCB"

    -- Montagebohrungen
  , mountHole (Point (-45)  25) 3
  , mountHole (Point ( 45)  25) 3
  , mountHole (Point (-45) (-25)) 3
  , mountHole (Point ( 45) (-25)) 3

    -- Steckerleiste links (z.B. 6-polig)
  , connector (Point (-50)  15) (Point (-40)  15) "J1"
  , connector (Point (-50)   5) (Point (-40)   5) "J2"
  , connector (Point (-50)  (-5)) (Point (-40)  (-5)) "J3"
  , connector (Point (-50) (-15)) (Point (-40) (-15)) "J4"
  , connector (Point (-50) (-25)) (Point (-40) (-25)) "J5"

    -- Sensor-Pad rechts
  , connector (Point 50  10) (Point 40  10) "SENS+"
  , connector (Point 50   0) (Point 40   0) "SENS-"
  , connector (Point 50 (-10)) (Point 40 (-10)) "REF"

    -- Beschriftung
  , label (Point 0 30) "Sensor-Board v1.0"
  , label (Point 0 (-30)) "MCU: U1, Regler: U2"

    -- Maßlinie Breite
  , dimension (Point (-50) (-35)) (Point 50 (-35)) "100 mm"
  , label (Point 0 (-40)) "Breite 100 mm"
  ]

main :: IO ()
main = do
  let svg = renderSVG pcbTheme pcb
  writeFile "pcb.svg" svg
  putStrLn "Wrote pcb.svg"

