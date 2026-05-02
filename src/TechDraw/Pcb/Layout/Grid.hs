module TechDraw.Pcb.Layout.Grid
  ( grid
  ) where

import TechDraw.Pcb.Types
import TechDraw.Pcb.Core (bbox, move)


-- | Place elements in a grid with given columns and spacing
grid :: Int -> Double -> Double -> [TechElement] -> TechElement
grid cols dx dy elems =
  EGroup (zipWith place [0..] elems)
  where
    place i el =
      let row = i `div` cols
          col = i `mod` cols
          (Point x0 y0, _) = bbox el
          tx = fromIntegral col * dx - x0
          ty = fromIntegral row * dy - y0
      in move tx ty el


