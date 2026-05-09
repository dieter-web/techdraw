module RotationTest where

import TechDraw.Electrical.TestAllSymbols (renderAllSymbols)
import TechDraw.SVG (SVG (..), SvgDoc (..))
import TechDraw.SVG.Render (renderSvgDoc)
import TechDraw.SVG.Types as T (Transform (..))

-- Rotationen, die wir testen
rotations :: [Double]
rotations = [0, 90, 180, 270]

cellSize :: Double
cellSize = 600

renderRotationTest :: IO ()
renderRotationTest = do
    putStrLn "Rendering rotation-test.svg ..."
    let doc = buildRotationTest
    writeFile "rotation-test.svg" (renderSvgDoc doc)
    putStrLn "Done."

buildRotationTest :: SvgDoc
buildRotationTest =
    SvgDoc
        { svgWidth = 4 * cellSize
        , svgHeight = cellSize
        , svgRoot = Group (zipWith renderRot [0 ..] rotations)
        }

renderRot :: Int -> Double -> SVG
renderRot idx angle =
    Transform
        ( T.TransformList
            [ T.Translate (fromIntegral idx * cellSize) 0
            , T.Rotate angle (0, 0)
            ]
        )
        renderAllSymbols
