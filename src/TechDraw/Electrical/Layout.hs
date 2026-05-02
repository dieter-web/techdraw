module TechDraw.Electrical.Layout where

import TechDraw.SVG.Types

snapToGrid :: Double -> Pos -> Pos
snapToGrid g (x,y) =
  ( fromIntegral (round (x/g)) * g
  , fromIntegral (round (y/g)) * g
  )

