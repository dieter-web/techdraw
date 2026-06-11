{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Text.IO as T
import TechDraw.Core.Types
-- import TechDraw.Core.Path
import TechDraw.Core.Style
import TechDraw.SVG.Render
import TechDraw.SVG.Types 

main :: IO ()
main = do
  let p1 = Point 10 10
      p2 = Point 20 20

      p  = Path [M p1, L p2]

      svg =
        svgWrap $
        "<path d=\"" <> renderPath p <> "\" style=\"" <> renderStyle defaultStyle <> "\"/>"

  T.writeFile "demo.svg" svg
  putStrLn "SVG erzeugt: demo.svg"
