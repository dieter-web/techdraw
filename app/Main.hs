module Main where

import TechDraw.SVG.Types
import TechDraw.SVG.Render
import TechDraw.Electrical.Symbols.Resistor
import TechDraw.Core.Types

main :: IO ()
main = do
  let r = resistor (Point 10 10) (Point 200 10)
      svg = SVGDoc 300 100 [r]
  writeFile "test.svg" (renderSVG svg)

