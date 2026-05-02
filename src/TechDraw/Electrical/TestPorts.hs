-- file: src/TechDraw/Electrical/TestPorts.hs
-- Damit kannst du eine SVG generieren, die alle Symbole in einem Raster zeigt, Ports rot markiert
module TechDraw.Electrical.TestPorts
  ( renderAllSymbolsWithPorts
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.Electrical.Types
import TechDraw.Electrical.Symbols
import TechDraw.Electrical.Ports

-- einfache Demo-Liste aller SymbolType
allSymbols :: [SymbolType]
allSymbols =
  [ Resistor, Potentiometer, Trimmer, ThermistorPTC, ThermistorNTC
  , Capacitor, CapacitorPolarized, CapacitorVariable, CapacitorTrimmer
  , Inductor, Transformer
  , SwitchOpen, SwitchClosed, SwitchSPDT, SwitchDPDT, SwitchToggle
  , Switch2P, PushButtonNO, PushButtonNC
  , Fuse, FuseHolder, FuseThermal, CircuitBreaker
  , Ground, EarthProtective
  , Motor, Lamp
  , Diode, LED, Zener
  , TransistorNPN, TransistorPNP, OpAmp
  , Battery, DCSource, ACSource
  , Connector, Terminal
  ]

renderAllSymbolsWithPorts :: SVG
renderAllSymbolsWithPorts =
  Group (zipWith renderAtPos allSymbols positions)
  where
    cols = 8
    dx   = 60
    dy   = 60

    positions =
      [ (fromIntegral (c * dx), fromIntegral (r * dy))
      | (i, _) <- zip [0..] allSymbols
      , let r = i `div` cols
      , let c = i `mod` cols
      ]

    renderAtPos t pos =
      let sym  = Symbol t pos 0
      in Group [ renderSym sym
               , renderPorts sym
               ]

renderSym :: Symbol -> SVG
renderSym (Symbol t (px, py) rot) =
  Transform (Translate px py) $
    Transform (Rotate rot (0,0)) $
      renderSymbolBase t

renderPorts :: Symbol -> SVG
renderPorts sym =
  Group (map renderPort (portsOfSymbol sym))
  where
    renderPort p =
      let (x, y) = portPos p
      in Group
           [ Circle (x, y) 2 (Just (StrokeColor "red" 0.5))
           , Line (x-3, y) (x+3, y) (Just (StrokeColor "red" 0.5))
           , Line (x, y-3) (x, y+3) (Just (StrokeColor "red" 0.5))
           ]
