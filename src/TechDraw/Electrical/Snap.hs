-- file: src/TechDraw/Electrical/Snap.hs
module TechDraw.Electrical.Snap
  ( snapToGrid
  , snapToPorts
  , snapBest
  ) where

import TechDraw.Electrical.Types
import TechDraw.Electrical.Ports

-- 1. Snap auf Grid
snapToGrid :: Double -> Pos -> Pos
snapToGrid g (x, y) =
  ( roundTo g x
  , roundTo g y
  )

roundTo :: Double -> Double -> Double
roundTo g v =
  fromIntegral (round (v / g)) * g

-- 2. Snap auf Ports vorhandener Symbole (wenn nah genug)
snapToPorts :: Double -> [Symbol] -> Pos -> Maybe Pos
snapToPorts radius syms (mx, my) =
  let allPorts = concatMap portsOfSymbol syms
      closePorts =
        [ portPos p
        | p <- allPorts
        , let (x, y) = portPos p
        , (x - mx)^2 + (y - my)^2 <= radius^2
        ]
  in case closePorts of
       (p:_) -> Just p
       []    -> Nothing

-- 3. Kombination: erst Ports, dann Grid
snapBest :: Double -> Double -> [Symbol] -> Pos -> Pos
snapBest radius grid syms p =
  case snapToPorts radius syms p of
    Just p' -> p'
    Nothing -> snapToGrid grid p
