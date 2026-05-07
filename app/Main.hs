module Main where

import System.IO (writeFile)

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Paths
import TechDraw.SVG.Render
import TechDraw.SVG.Path.Render
import TechDraw.Electrical.Render
import TechDraw.Electrical.Types


-- Catmull-Rom -> kubische Beziersegment
catmullRomToBezier :: [Pt] -> [PathCommand]
catmullRomToBezier pts = case pts of
  (p0:p1:p2:p3:rest) ->
    let (x0,y0) = p0
        (x1,y1) = p1
        (x2,y2) = p2
        (x3,y3) = p3

        c1 = (x1 + (x2 - x0) / 6, y1 + (y2 - y0) / 6)
        c2 = (x2 - (x2 - x1) / 6, y2 - (y3 - y1) / 6)
    in CubicTo (fst c1) (snd c1) (fst c2)(snd c2) x2 y2
       : catmullRomToBezier (p1:p2:p3:rest)
  _ -> []

smoothSpline :: [Pt] -> SVG
smoothSpline (p0:pts) =
  Path
    (MoveTo (fst p0) (snd p0) : catmullRomToBezier (p0:pts))
    (Just (StrokeColor "blue" 2))
    FillNone
smoothSpline [] =
  Group []

-- Beispielpunkte für eine glatte Kurve
examplePoints :: [Pt]
examplePoints = 
  [ (10,80)
  , (30,20)
  , (60,120)
  , (90, 40)
  , (120, 80)
  ]

scene :: SVG
scene = 
  Group
    [ smoothSpline examplePoints
    , Text (10,15) AnchorStart "Splin-Demo"
    ]

main :: IO ()
main = do
  let doc = SvgDoc
        { svgWidth = 800
        , svgHeight = 600
        , svgRoot = scene
        }
  let svgContent = renderSvgDoc doc
  writeFile "spline-demo.svg" svgContent
  putStrLn "spline-demo.svg geschrieben."
