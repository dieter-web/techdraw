{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Symbols.Inductor where

import TechDraw.Core.Types
import TechDraw.Core.Style

inductor :: Point -> Point -> (Shape, Stroke, Maybe Fill)
inductor p1 p2 =
  let v      = sub p2 p1
      n      = normalize v
      o      = scale 6 (ortho n)      -- Höhe der Bögen
      seg    = scale (1/5) v          -- 5 Segmente: Leitung + 4 Bögen

      pA     = add p1 seg
      pB     = add pA seg
      pC     = add pB seg
      pD     = add pC seg
      pEnd   = add pD seg
  in
    ( SPath
        [ M p1
        , L pA

        -- Bogen 1
        , M pA
        , L (add pA o)
        , L (add pB o)
        , L pB

        -- Bogen 2
        , M pB
        , L (add pB o)
        , L (add pC o)
        , L pC

        -- Bogen 3
        , M pC
        , L (add pC o)
        , L (add pD o)
        , L pD

        -- Bogen 4
        , M pD
        , L (add pD o)
        , L (add pEnd o)
        , L pEnd

        -- Leitung zum Ende
        , M pEnd
        , L p2
        ]
    , Stroke "black" 2
    , Nothing
    )

