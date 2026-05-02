module Main where

import TechDraw
import TechDraw.Types
import TechDraw.Export.SVG (renderSVG)
import System.IO (writeFile)

pcb2 :: [TechElement]
pcb2 =
  [ moduleBox (Point (-50) (-30)) 100 60 "PCB"

  -- Pads
  , pad (Point (-40) 10) 3 3 RoundPad "J1"
  , pad (Point (-40) 0) 3 3 RoundPad "J2"
  , pad (Point (-40) (-10)) 3 3 RoundPad "J3"

  -- Routing
  , trace [Point (-40) 10, Point (-20) 10, Point (-10) 0, Point 20 0] 1.2

  -- Silkscreen
  , silkText (Point 0 25) "Sensor Board v2.0"
  , silkLine (Point (-45) 20) (Point 45 20)
  , silkCircle (Point 0 0) 5
  ]

main :: IO ()
main = do
  let svg = renderSVG pcbTheme pcb2
  writeFile "pcb2.svg" svg
  putStrLn "Wrote pcb2.svg"
