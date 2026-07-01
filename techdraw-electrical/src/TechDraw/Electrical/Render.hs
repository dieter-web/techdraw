{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Electrical.Render
  ( renderElement,
    renderElectrical,
    toSvgDoc,
  )
where

import TechDraw.Core.Style
import TechDraw.Core.Transform
import TechDraw.Core.Types
import TechDraw.Electrical.Symbols.Resistor
import TechDraw.Electrical.Types

-- ============================================================
-- 1. Symbol auswählen (reine Geometrie am Ursprung)
-- ============================================================

symbolOf :: Symbol -> (Shape, Stroke, Maybe Fill)
symbolOf ResistorIEC = resistorRectSymbol
symbolOf ResistorZigZag = resistorZigZagSymbol
symbolOf _ = resistorRectSymbol -- fallback

-- ============================================================
-- 2. Transform anwenden (Position + Rotation)
-- ============================================================

applyElementTransform ::
  ElectricalElement ->
  (Shape, Stroke, Maybe Fill) ->
  (Shape, Stroke, Maybe Fill)
applyElementTransform el (sh, st, mf) =
  let pos = elPosition el
      rot = elOrientation el
      tf = rotate rot <> translate pos
   in ( transformShape tf sh,
        st,
        mf
      )

-- ============================================================
-- 3. Leads generieren (Anschlussleitungen)
-- ============================================================

renderLeads :: ElectricalElement -> [(Shape, Stroke, Maybe Fill)]
renderLeads el =
  let pos = elPosition el
      rot = elOrientation el
      dir = orientationVector rot
      leadLen = 20

      pIn = pos - scale leadLen dir
      pOut = pos + scale leadLen dir

      leadStroke = Stroke "black" 2
   in [ (SPath [M pIn, L pos], leadStroke, Nothing),
        (SPath [M pos, L pOut], leadStroke, Nothing)
      ]

-- ============================================================
-- 4. Element rendern (Symbol + Leads)
-- ============================================================

renderElement :: ElectricalElement -> [(Shape, Stroke, Maybe Fill)]
renderElement el =
  let baseSymbol = symbolOf (elSymbol el)
      transformedSymbol = applyElementTransform el baseSymbol
      leads = renderLeads el
   in leads ++ [transformedSymbol]

-- ============================================================
-- 5. Gesamtschaltplan rendern
-- ============================================================

renderElectrical :: ElectricalDiagram -> [(Shape, Stroke, Maybe Fill)]
renderElectrical (ElectricalDiagram elements wires) =
  concatMap renderElement elements
    ++ concatMap renderWire wires
