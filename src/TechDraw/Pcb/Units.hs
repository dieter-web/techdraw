{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module TechDraw.Pcb.Units
  ( Unit(..)
  , Quantity(..)
  , mm, cm, m
  , inch, mil
  , px, pt
  , toUnit
  , toMM
  , toPX
  , scaleQuantity
  ) where

--------------------------------------------------------------------------------
-- | Einheitensystem für TechDraw
--
--   Ziel:
--     - einheitliche Darstellung physikalischer Größen
--     - einfache Umrechnung
--     - SVG‑Integration (px)
--     - technische Einheiten (mm, inch, mil)
--
--------------------------------------------------------------------------------

-- | Unterstützte Einheiten
data Unit
  = U_MM       -- Millimeter
  | U_CM       -- Zentimeter
  | U_M        -- Meter
  | U_INCH     -- Zoll
  | U_MIL      -- 1/1000 inch
  | U_PX       -- Pixel (SVG)
  | U_PT       -- Punkt (1/72 inch)
  deriving (Eq, Show)

-- | Physikalische Größe mit Einheit
newtype Quantity = Quantity { unQ :: (Double, Unit) }
  deriving (Eq, Show)

--------------------------------------------------------------------------------
-- Konstruktoren für bequeme Literale
--------------------------------------------------------------------------------

mm :: Double -> Quantity
mm x = Quantity (x, U_MM)

cm :: Double -> Quantity
cm x = Quantity (x, U_CM)

m :: Double -> Quantity
m x = Quantity (x, U_M)

inch :: Double -> Quantity
inch x = Quantity (x, U_INCH)

mil :: Double -> Quantity
mil x = Quantity (x, U_MIL)

px :: Double -> Quantity
px x = Quantity (x, U_PX)

pt :: Double -> Quantity
pt x = Quantity (x, U_PT)

--------------------------------------------------------------------------------
-- Umrechnungsfaktoren
--------------------------------------------------------------------------------

-- | Umrechnungsfaktor nach Millimeter
factorToMM :: Unit -> Double
factorToMM U_MM   = 1
factorToMM U_CM   = 10
factorToMM U_M    = 1000
factorToMM U_INCH = 25.4
factorToMM U_MIL  = 0.0254
factorToMM U_PX   = 0.264583   -- 96 dpi SVG Standard
factorToMM U_PT   = 0.352778   -- 1 pt = 1/72 inch

-- | Umrechnungsfaktor von Millimeter in Ziel‑Einheit
factorFromMM :: Unit -> Double
factorFromMM U_MM   = 1
factorFromMM U_CM   = 0.1
factorFromMM U_M    = 0.001
factorFromMM U_INCH = 1 / 25.4
factorFromMM U_MIL  = 1 / 0.0254
factorFromMM U_PX   = 1 / 0.264583
factorFromMM U_PT   = 1 / 0.352778

--------------------------------------------------------------------------------
-- Umrechnung
--------------------------------------------------------------------------------

-- | Allgemeine Umrechnung zwischen Einheiten
toUnit :: Unit -> Quantity -> Quantity
toUnit target (Quantity (x,u)) =
  let mmVal = x * factorToMM u
      newVal = mmVal * factorFromMM target
  in Quantity (newVal, target)

-- | Spezialisierte Umrechnungen
toMM :: Quantity -> Double
toMM (Quantity (x,u)) = x * factorToMM u

toPX :: Quantity -> Double
toPX q = let Quantity (v,_) = toUnit U_PX q in v

--------------------------------------------------------------------------------
-- Skalierung
--------------------------------------------------------------------------------

-- | Skaliert eine Quantity (z. B. für Zoom, Layout, DPI‑Anpassung)
scaleQuantity :: Double -> Quantity -> Quantity
scaleQuantity s (Quantity (x,u)) = Quantity (x*s, u)
