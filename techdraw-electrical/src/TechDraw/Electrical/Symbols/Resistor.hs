{-# LANGUAGE OverloadedStrings #-}
module TechDraw.Electrical.Symbols.Resistor where

import TechDraw.Core.Types
import TechDraw.Core.Style
-- import Data.Text(Text)

resistor :: Point -> Point -> (Shape, Stroke, Maybe Fill)
resistor p1 p2 =
  let v = p2 - p1
      n = normalize v
      -- orthogonale Richtung (90° gedreht)
      o = ortho n  -- z.B. ortho (x,y) = (-y, x)
      amp = 10 -- Amplitude des Zickzacks
      
      step = scale(dist p1 p2 / 6) n

      pA = p1
      pB = p1 + step + scale amp o
      pC = p1 + scale 2 step - scale amp o
      pD = p1 + scale 3 step + scale amp o
      pE = p1 + scale 4 step - scale amp o
      pF = p1 + scale 5 step + scale amp o
      pG = p2
  in
    (SPath [M pA, L pB, L pC, L pD, L pE, L pF, L pG]
    , Stroke "black" 2
    , Nothing
    )

-- | Rechteckiger IEC-Widerstand (drehbar)
resistorRect :: Point -> Point -> (Shape, Stroke, Maybe Fill)
resistorRect p1 p2 =
  let v = p2 - p1
      n = normalize v
      o = ortho n -- orthogonale Richtung
      h = 10      -- halbe Höhe des Rechtecks 

      -- vier Ecken 
      pA = p1 + scale h o
      pB = p2 + scale h o
      pC = p2 - scale h o
      pD = p1 - scale h o
  in (SPath [ M pA, L pB, L pC, L pD, L pA]
     , Stroke "black" 2
     , Just (Fill "white")
  )

resistorRectWithLeads :: Point -> Point -> (Shape, Stroke, Maybe Fill)
resistorRectWithLeads p1 p2 =
  let v = p2 - p1
      n = normalize v
      o = ortho n
      h = 10     -- halbe Höhe des Rechtecks
      lead = 20  -- Länge der Anschlussleitungen 

      -- Punkte der Anschlussleitungen 
      pIn  = p1 - scale lead n
      pOut = p2 + scale lead n

      -- vier Ecken des Rechtecks 
      pA = p1 + scale h o
      pB = p2 + scale h o
      pC = p2 - scale h o
      pD = p1 - scale h o 
  in ( SPath
         [ M pIn, L p1 --Eingang
         , L pA, L pB, L pC, L pD, L pA -- Rechteck
         , M p2, L pOut
         ]
     , Stroke "black" 2
     , Just (Fill "#00ff00")
  )

-- | Rechteckiger IEC-Widerstand mit parametrisierbarer Leitungslänge
resistorRectWidthLeads :: Double -> Point -> Point -> (Shape, Stroke, Maybe Fill)
resistorRectWidthLeads leadLen p1 p2 = 
  let v = p2 - p1
      n = normalize v
      o = ortho n
      h = 10  -- halbe Höhe des Rechtecks 

      -- Anschlussleitungen
      pIn  = p1 - scale leadLen n
      pOut = p2 + scale leadLen n

      -- vier Ecken des Rechtecks 
      pA = p1 + scale h o
      pB = p2 + scale h o
      pC = p2 - scale h o
      pD = p1 - scale h o
  in ( SPath
         [ M pIn, L p1
         , L pA, L pB, L pC, L pD, L pA
         , M p2, L pOut
         ]
     , Stroke "black" 2
     , Just (Fill "#00ff00")
     )

-- | Rechteckiger IEC-Widerstand mit automatisch abgeleiteter Leitungslänge 
resistorRectAutoLead :: Point -> Point -> (Shape, Stroke, Maybe Fill)
resistorRectAutoLead p1 p2 =
  let v = p2 - p1
      n = normalize v
      o = ortho n
      h = 10 -- halbe Höhe des Rechtcks 
      leadLen = 2.5 * h -- Leitungslänge proportional zur Symbolgröße

      -- Anschlussleitungen 
      pIn  = p1 - scale leadLen n 
      pOut = p2 + scale leadLen n

      -- vier Ecken des Rechtecks 
      pA = p1 + scale h o
      pB = p2 + scale h o
      pC = p2 - scale h o
      pD = p1 - scale h o
  in ( SPath
        [ M pIn, L p1
        , L pA, L pB, L pC, L pD, L pA
        , M p2, L pOut
        ]
     , Stroke "black" 2
     , Just (Fill "#00ff00")
     )


