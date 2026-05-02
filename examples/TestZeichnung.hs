module Main where

import TechDraw
import System.IO(writeFile)

import TechDraw.SVG
import TechDraw.SVG.Types

-- import TechDraw.Utils

main :: IO ()
main = do
  let root = group
        [ rect (10,10) 30 20
        , line (10,20) (0,20)
        , line (40,20) (60,20)
        , text (10,8) "K1"
        ]
  let doc = SvgDoc 100 50 root
  writeFile "test.svg" (renderSvgDoc doc)

