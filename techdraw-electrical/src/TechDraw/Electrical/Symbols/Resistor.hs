{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Symbols.Resistor
  ( resistorZigZagSymbol,
    resistorRectSymbol,
    resistorRectFilledSymbol,
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Types

-- | Klassischer Zickzack-Widerstand (Symbolgeometrie am Ursprung)
resistorZigZagSymbol :: (Shape, Stroke, Maybe Fill)
resistorZigZagSymbol =
  let amp = 10 -- Amplitude
      step = 10 -- horizontale Schrittweite
      pA = Point (step * (-3)) 0
      pB = Point (step * (-2)) amp
      pC = Point (-step) (-amp)
      pD = Point 0 amp
      pE = Point step (-amp)
      pF = Point (step * 2) amp
      pG = Point (step * 3) 0
   in ( SPath [M pA, L pB, L pC, L pD, L pE, L pF, L pG],
        Stroke "black" 2,
        Nothing
      )

-- | IEC-Rechteck-Widerstand (Symbolgeometrie am Ursprung)
resistorRectSymbol :: (Shape, Stroke, Maybe Fill)
resistorRectSymbol =
  let w = 40 -- Breite
      h = 10 -- halbe Höhe
      pA = Point (-(w / 2)) h
      pB = Point (w / 2) h
      pC = Point (w / 2) (-h)
      pD = Point (-(w / 2)) (-h)
   in ( SPath [M pA, L pB, L pC, L pD, L pA],
        Stroke "black" 2,
        Nothing
      )

-- | IEC-Rechteck-Widerstand mit Füllung (Symbolgeometrie am Ursprung)
resistorRectFilledSymbol :: (Shape, Stroke, Maybe Fill)
resistorRectFilledSymbol =
  let w = 40
      h = 10
      pA = Point (-(w / 2)) h
      pB = Point (w / 2) h
      pC = Point (w / 2) (-h)
      pD = Point (-(w / 2)) (-h)
   in ( SPath [M pA, L pB, L pC, L pD, L pA],
        Stroke "black" 2,
        Just defaultFill
      )
