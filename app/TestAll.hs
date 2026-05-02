module Main where

--import TechDraw.Electrical.TestAllSymbols
--import TechDraw.SVG.Render
--import System.IO
--main :: IO ()
--in= writeFile "all-symbols.svg" (renderSvgDoc renderAllSymbols) 
import TechDraw.SVG
import TechDraw.SVG.Render
import TechDraw.Electrical.TestAllSymbols (renderAllSymbols)

main :: IO ()
main =
  writeFile "all-symbols.svg" $
  renderSvgDoc SvgDoc
    { svgWidth = 1200 
    , svgHeight = 1200
    , svgRoot = renderAllSymbols
    }
