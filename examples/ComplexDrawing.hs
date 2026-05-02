module Main where

import TechDraw
import TechDraw.Types
import TechDraw.Export.SVG (renderSVG)
import System.IO (writeFile)

drawing :: [TechElement]
drawing =
  [ moduleBox (Point 0 0) 6 4 "Sensor"
  , connector (Point (-2.5) 0) (Point 0 0) "IN"
  , connector (Point 2.5 0) (Point 6 0) "OUT"
  , mountHole (Point (-2) 1.5) 0.3
  , mountHole (Point 2 1.5) 0.3
  , label (Point 0 5) "Sensor Module"
  ]

main :: IO ()
main = do
  let svg = renderSVG defaultTheme drawing
  writeFile "complex.svg" svg
  putStrLn "Wrote complex.svg"


