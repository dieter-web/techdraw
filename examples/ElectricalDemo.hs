module Main where

import TechDraw.SVG
import TechDraw.SVG.Render
import TechDraw.Electrical.Types
import TechDraw.Electrical.Render

main :: IO ()
main = do
  let circuit = Electrical
        { symbols =
            [ Symbol Resistor     (50,50) 0
            , Symbol Lamp         (150,50) 0
            , Symbol Ground       (100,120) 0
            , Symbol SwitchOpen   (50,90) 0
            , Symbol Fuse         (100,90) 0
            ]

        , wires =
            [ Wire [(90,50),(150,50)] -- Offset beachten
            , Wire [(150,120),(100,120)]
            , Wire [(75,90),(100,90)]
            ]
        }

  writeFile "electrical-demo.svg"
    (renderSvgDoc (
      SvgDoc
        { svgWidth = 400
        , svgHeight = 300
        , svgRoot = renderElectrical circuit
        }
      )
    )
