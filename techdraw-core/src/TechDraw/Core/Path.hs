module TechDraw.Core.Path
  ( path
  , moveTo
  , lineTo
  , closePath
  ) where

import TechDraw.Core.Types


-- | Erzeugt eine Shape aus einer Liste von Path-Kommandos.
path :: [PathCmd] -> Shape
path = SPath

-- | MoveTo-Kommando
moveTo :: Double -> Double -> PathCmd
moveTo x y = M (Point x y)

-- | LineTo-Kommando
lineTo :: Double -> Double -> PathCmd
lineTo x y = L (Point x y)

-- | ClosePath-Kommando
closePath :: PathCmd
closePath = Z

