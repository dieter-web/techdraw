-- file: src/TechDraw/Electrical/Symbols/ACSource.hs
module TechDraw.Electrical.Symbols.ACSource
  ( renderACSource
  ) where

import TechDraw.SVG -- enthält Stroke, SVG, Line, Group
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.3)

renderACSource :: Pos -> SVG
renderACSource (x, y) =
  Group
    [ Circle (x, y) 10 stroke FillNone
    , Line (x-16, y) (x-10, y) stroke
    , Line (x+10, y) (x+16, y) stroke
    , Polyline
        [ (x-6, y+2)
        , (x-4, y-2)
        , (x-2, y+2)
        , (x,   y-2)
        , (x+2, y+2)
        , (x+4, y-2)
        , (x+6, y+2)
        ]
        stroke
    ]
