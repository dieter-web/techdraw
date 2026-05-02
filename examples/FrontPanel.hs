module Main where

import TechDraw
import TechDraw.Types
import TechDraw.Export.SVG (renderSVG)
import System.IO (writeFile)

frontPanel :: [TechElement]
frontPanel =
  [ moduleBox (Point 0 0) 10 6 "Front Panel"
  , connector (Point 1 3) (Point 3 3) "IN"
  , connector (Point 7 3) (Point 9 3) "OUT"
  , mountHole (Point 1 1) 0.4
  , mountHole (Point 9 1) 0.4
  , mountHole (Point 1 5) 0.4
  , mountHole (Point 9 5) 0.4
  , label (Point 4 5.5) "Control Unit"
  ]

main :: IO ()
main = do
  let svg = renderSVG defaultTheme frontPanel
  writeFile "frontpanel.svg" svg
  putStrLn "Wrote frontpanel.svg"

