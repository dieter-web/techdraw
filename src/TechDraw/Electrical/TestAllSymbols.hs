module TechDraw.Electrical.TestAllSymbols
  ( renderAllSymbols
  , renderAllSymbolsWithPorts
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.SVG.Defaults (strokeDefault, fillNone)

import TechDraw.Electrical.Types
import TechDraw.Electrical.Symbols (renderSymbol, renderSymbolRaw)
import TechDraw.Electrical.Ports (portsOfSymbol)
import TechDraw.Electrical.Render

-- ------------------------------------------------------------
-- Liste aller SymbolType-Konstruktoren
-- ------------------------------------------------------------

allSymbols :: [SymbolType]
allSymbols =
  [ Resistor
  , Potentiometer
  , Trimmer
  , ThermistorPTC
  , ThermistorNTC
  , Capacitor
  , CapacitorPolarized
  , CapacitorVariable
  , CapacitorTrimmer
  , Inductor
  , Transformer
  , SwitchOpen
  , SwitchClosed
  , SwitchSPDT
  , SwitchDPDT
  , SwitchToggle
  , Switch2P
  , PushButtonNO
  , PushButtonNC
  , Fuse
  , FuseHolder
  , FuseThermal
  , CircuitBreaker
  , Ground
  , EarthProtective
  , Motor
  , Lamp
  , Diode
  , LED
  , Zener
  , TransistorNPN
  , TransistorPNP
  , OpAmp
  , Battery
  , DCSource
  , ACSource
  , Connector
  , Terminal
  ]

-- ------------------------------------------------------------
-- Rasterpositionen für alle Symbole
-- ------------------------------------------------------------

positions :: [Pos]
positions =
  [ (fromIntegral (c * dx), fromIntegral (r * dy))
  | (i, _) <- zip [0..] allSymbols
  , let r = i `div` cols
  , let c = i `mod` cols
  ]
  where
    cols = 8
    dx   = 120
    dy   = 120

-- ------------------------------------------------------------
-- Hilfsfunktion: Symbol an Position rendern
-- ------------------------------------------------------------
renderAtPos :: SymbolType -> Pos -> SVG
renderAtPos sym (x,y) =
  Transform [ Translate x y] (renderSymbolRaw sym(0,0))


--renderAtPos :: SymbolType -> Pos -> SVG--
--renderAtPos t pos =
--  renderSymbol t pos

-- ------------------------------------------------------------
-- Testbild: alle Symbole ohne Ports
-- ------------------------------------------------------------

renderAllSymbols :: SVG
renderAllSymbols =
  Group (zipWith renderAtPos allSymbols positions)

-- ------------------------------------------------------------
-- Ports sichtbar machen
-- ------------------------------------------------------------

renderPort :: Port -> SVG
renderPort (Port name (x,y) _) =
  Group
    [ Circle (x,y) 4 strokeDefault fillNone
    , Text (x+6, y-6) AnchorStart name
    ]

renderSymbolWithPorts :: SymbolType -> Pos -> SVG
renderSymbolWithPorts t pos =
  let sym = Symbol t pos 0 1
  in Group
       [ renderSymbol t pos
       , Group (map renderPort (portsOfSymbol sym))
       ]

-- ------------------------------------------------------------
-- Testbild: alle Symbole mit Ports
-- ------------------------------------------------------------

renderAllSymbolsWithPorts :: SVG
renderAllSymbolsWithPorts =
  Group (zipWith renderSymbolWithPorts allSymbols positions)

