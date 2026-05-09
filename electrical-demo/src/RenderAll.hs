module RenderAll where

import TechDraw.Electrical.TestAllSymbols (renderAllSymbols)
import TechDraw.SVG.Render (renderSvgDoc)

import TechDraw.SVG (SvgDoc (..))

renderDemo :: IO ()
renderDemo = do
    let doc =
            SvgDoc
                { svgWidth = 1200
                , svgHeight = 1200
                , svgRoot = renderAllSymbols
                }
    writeFile "demo-output.svg" (renderSvgDoc doc)
    putStrLn "Done."
