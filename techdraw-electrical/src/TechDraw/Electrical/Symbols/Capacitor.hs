{-# LANGUAGE OverloadedStrings #-}
module TechDraw.Electrical.Symbols.Capacitor where

import TechDraw.Core.Types
import TechDraw.Core.Style

capacitor :: Point -> Point -> (Shape, Stroke, Maybe Fill)
capacitor p1 p2 =
  let v = p2 - p1
      n = normalize v
      o = scale 5 (ortho n) -- Plattenhöhe
      mitte = p1 + scale 0.5 v

      -- Plattenpunkte
      leftA = mitte - o
      leftB = mitte + o
      rightA = mitte - o + scale 10 n
      rightB = mitte + o + scale 10 n
  in
    ( SPath
      [ M p1
      , L mitte
      , M leftA, L leftB
      , M rightA,L rightB
      , M (mitte + scale 10 n)
      , L p2
      ]
    , Stroke "black" 2
    , Nothing
      )
