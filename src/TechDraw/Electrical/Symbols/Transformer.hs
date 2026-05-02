-- file: src/TechDraw/Electrical/Symbols/Transformer.hs
module TechDraw.Electrical.Symbols.Transformer
  ( renderTransformer
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderTransformer :: Pos -> SVG
renderTransformer (x, y) =
  Group
    [ -- Primärspule
      Polyline
        [ (x-16, y-8)
        , (x-12, y-14)
        , (x-8,  y-8)
        , (x-4,  y-14)
        , (x,    y-8)
        ]
        stroke
    , Line (x-20, y-8) (x-16, y-8) stroke
    , Line (x,    y-8) (x+4,  y-8) stroke
      -- Sekundärspule
    , Polyline
        [ (x-16, y+8)
        , (x-12, y+14)
        , (x-8,  y+8)
        , (x-4,  y+14)
        , (x,    y+8)
        ]
        stroke
    , Line (x-20, y+8) (x-16, y+8) stroke
    , Line (x,    y+8) (x+4,  y+8) stroke
      -- Magnetischer Kern
    , Line (x-6, y-4) (x-6, y+4) stroke
    , Line (x-2, y-4) (x-2, y+4) stroke
    ]
