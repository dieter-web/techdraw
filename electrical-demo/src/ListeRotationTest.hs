module ListeRotationTest where

import TechDraw.Electrical.AllSymbols (allSymbols) -- Liste [(String, SVG)]
import TechDraw.SVG (SVG (..), SvgDoc (..))
import TechDraw.SVG.Render (renderSvgDoc)
import TechDraw.SVG.Transform (rotateAround, translate)
import TechDraw.SVG.Types as T (Transform (..))

rotations :: [Double]
rotations = [0, 90, 180, 270]

-- | Abstand zwischen Symbolen
cellSize :: Double
cellSize = 300

renderRotationTest :: IO ()
renderRotationTest = do
    putStrLn "Rendering rotation-test.svg ..."
    let svg = buildRotationTest
    writeFile "rotation-test.svg" (renderSvgDoc svg)
    putStrLn "Done."

-- Gesamte SVG-Dokument
buildRotationTest :: SvgDoc
buildRotationTest =
    SvgDoc
        { svgWidth = fromIntegral (length rotations) * cellSize
        , svgHeight = fromIntegral (length allSymbols) * cellSize
        , svgRoot = Group (zipWith renderRow [0 ..] allSymbols)
        }

-- Eine Zeile pro Symbol
renderRow :: Int -> (String, SVG) -> SVG
renderRow row (_, sym) =
    Group
        [ renderRot col angle sym
        | (col, angle) <- zip [0 ..] rotations
        ]

-- Ein Symbol in einer Rotation
renderRot :: Int -> Double -> SVG -> SVG
renderRot col angle sym =
    Transform
        ( T.TransformList
            [ T.Translate (fromIntegral col * cellSize) 100
            , T.Rotate angle (0, 0)
            ]
        )
        sym
