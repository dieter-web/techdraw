module TechDraw.Electrical.Symbols.Transformers
  ( renderTransformer
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Path

stroke = Just (StrokeColor "black" 1)

renderTransformer :: Point -> SVG
renderTransformer (x,y) =
  Group
    [ Path
        [ MoveTo x y
        , ArcTo 6 6 0 False True (x+12) y
        , ArcTo 6 6 0 False True (x+24) y
        ]
        stroke FillNone
    , Path
        [ MoveTo (x+30) y
        , ArcTo 6 6 0 False True (x+42) y
        , ArcTo 6 6 0 False True (x+54) y
        ]
        stroke FillNone
    ]
