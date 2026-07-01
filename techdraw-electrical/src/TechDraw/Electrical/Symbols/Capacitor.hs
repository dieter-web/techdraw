{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Symbols.Capacitor where

import TechDraw.Core.Style
import TechDraw.Core.Types

capacitor :: Point -> Point -> (Shape, Stroke, Maybe Fill)
capacitor p1 p2 =
  let v = p2 - p1
      n = pnormalize v
      o = pscale 5 (portho n) -- Plattenhöhe
      mitte = p1 + pscale 0.5 v

      -- Plattenpunkte
      leftA = mitte - o
      leftB = mitte + o
      rightA = mitte - o + pscale 10 n
      rightB = mitte + o + pscale 10 n
   in ( SPath
          [ M p1,
            L mitte,
            M leftA,
            L leftB,
            M rightA,
            L rightB,
            M (mitte + pscale 10 n),
            L p2
          ],
        Stroke "black" 2,
        Nothing
      )
