{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Symbols.Inductor where

import TechDraw.Core.Style
import TechDraw.Core.Types

inductor :: Point -> Point -> (Shape, Stroke, Maybe Fill)
inductor p1 p2 =
  let v = psub p2 p1
      n = pnormalize v
      o = pscale 6 (portho n) -- Höhe der Bögen
      seg = pscale (1 / 5) v -- 5 Segmente: Leitung + 4 Bögen
      pA = padd p1 seg
      pB = padd pA seg
      pC = padd pB seg
      pD = padd pC seg
      pEnd = padd pD seg
   in ( SPath
          [ M p1,
            L pA,
            -- Bogen 1
            M pA,
            L (padd pA o),
            L (padd pB o),
            L pB,
            -- Bogen 2
            M pB,
            L (padd pB o),
            L (padd pC o),
            L pC,
            -- Bogen 3
            M pC,
            L (padd pC o),
            L (padd pD o),
            L pD,
            -- Bogen 4
            M pD,
            L (padd pD o),
            L (padd pEnd o),
            L pEnd,
            -- Leitung zum Ende
            M pEnd,
            L p2
          ],
        Stroke "black" 2,
        Nothing
      )
