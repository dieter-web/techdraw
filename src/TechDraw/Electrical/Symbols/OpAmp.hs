-- file: src/TechDraw/Electrical/Symbols/OpAmp.hs
module TechDraw.Electrical.Symbols.OpAmp
  ( renderOpAmp
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

renderOpAmp :: Pos -> SVG
renderOpAmp (x, y) =
  Group
    [ Polyline
        [ (x-10, y-12)
        , (x+10, y)
        , (x-10, y+12)
        , (x-10, y-12)
        ]
        stroke
      -- Eingänge
    , Line (x-18, y-6) (x-10, y-6) stroke
    , Line (x-18, y+6) (x-10, y+6) stroke
      -- Ausgang
    , Line (x+10, y) (x+18, y) stroke
      -- + und -
    , Line (x-16, y-8) (x-12, y-8) stroke
    , Line (x-14, y-10) (x-14, y-6) stroke
    , Line (x-16, y+6) (x-12, y+6) stroke
    ]
