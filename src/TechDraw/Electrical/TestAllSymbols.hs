module TechDraw.Electrical.TestAllSymbols (
    renderAllSymbols,
) where

import TechDraw.SVG
import TechDraw.SVG.Defaults (fillNone, strokeDefault)
import TechDraw.SVG.Types

import TechDraw.Electrical.Ports (portsOfSymbol)
import TechDraw.Electrical.Render
import TechDraw.Electrical.Symbols (renderSymbol)
import TechDraw.Electrical.Types

---------------------------------------
-- Liste aller SymbolType-Konstruktoren
-- ------------------------------------
--
symbolNames :: [(SymbolType, String)]
symbolNames =
    [ (Resistor, "Resistor")
    , (Potentiometer, "Potentiometer")
    , (Trimmer, "Trimmer")
    , (ThermistorPTC, "ThermistorPTC")
    , (ThermistorNTC, "ThermistorNTC")
    , (Capacitor, "Capacitor")
    , (CapacitorPolarized, "CapacitorPolar")
    , (CapacitorVariable, "CapacitorVariable")
    , (CapacitorTrimmer, "CapacitorTrimmer")
    , (Inductor, "Inductor")
    , (Transformer, "Transformer")
    , (SwitchOpen, "SwitchOpen")
    , (SwitchClosed, "SwitchClosed")
    , (SwitchSPDT, "SwitchSPDT")
    , (SwitchDPDT, "SwitchDPDT")
    , (SwitchToggle, "SwitchToggle")
    , (Switch2P, "Switch2P")
    , (PushButtonNO, "PushButtonNO")
    , (PushButtonNC, "PushButtonNC")
    , (Fuse, "Fuse")
    , (FuseHolder, "FuseHolder")
    , (FuseThermal, "FuseThermal")
    , (CircuitBreaker, "CircuitBreaker")
    , (Ground, "Ground")
    , (EarthProtective, "EarthProtective")
    , (Lamp, "Lamp")
    , (Motor, "Motor")
    , (Diode, "Diode")
    , (LED, "LED")
    , (Zener, "Zener")
    , (Battery, "Battery")
    , (DCSource, "DCSource")
    , (ACSource, "ACSource")
    , (Terminal, "Terminal")
    , (Connector, "Connector")
    ]

-- Position im Raster
positions :: [Pos]
positions =
    [ (fromIntegral (c * dx), fromIntegral (r * dy))
    | i <- [0 .. length symbolNames - 1]
    , let r = i `div` cols
    , let c = i `mod` cols
    ]
  where
    cols = 8
    dx = 120
    dy = 120

-- Symbolinstanz erzeugen
mkSymbol :: SymbolType -> Pos -> Symbol
mkSymbol t pos =
    Symbol
        { symType = t
        , symPos = pos
        , symRot = 0
        , symScale = 1
        }

-- Symbol + Name rendern
renderAtPos :: (SymbolType, String) -> Pos -> SVG
renderAtPos (t, name) pos =
    Group
        [ renderSym (mkSymbol t pos)
        , Group (map renderPort (portsOfSymbol (mkSymbol t pos)))
        , Text (fst pos, snd pos + 40) AnchorMiddle name
        ]

-- Alle Symbole rendern
renderAllSymbols :: SVG
renderAllSymbols =
    Group (zipWith renderAtPos symbolNames positions)

renderPort :: Port -> SVG
renderPort (Port name (x, y) dir) =
    Group
        [ Circle (x, y) 3 strokeDefault fillNone
        , Text (x + 5, y - 5) AnchorStart name
        ]

testWireLayout :: SVG
testWireLayout =
    let s1 = Symbol Resistor (100, 100) 0 1
        s2 = Symbol Capacitor (300, 100) 0 1
        w1 = connect s1 "B" s2 "A"
     in Group
            [ renderSym s1
            , renderSym s2
            , renderWire w1
            ]

-- Old
-- renderAllSymbols :: SVG
-- renderAllSymbols =
--  Group (zipWith renderAtPos symbolNames positions)
--  where
--    cols = 8
--    dx   = 120
--    dy   = 120
--
--    positions :: [Pos]
--    positions =
--      [ (fromIntegral (c * dx), fromIntegral (r * dy))
--      | i <- [0 .. length symbolNames - 1]
--      , let r = i `div` cols
--      , let c = i `mod` cols
--      ]

--    renderAtPos :: (SymbolType, String) -> Pos -> SVG
--    renderAtPos (t, name) (px, py) =
--      Group
--        [ Transform (Translate px py) $
--            Transform (Scale 0.8 0.8) $
--              Transform (Rotate 15 (0,0)) $
--                renderSymbol t (0,0)
--        , Text (px, py + 40) AnchorMiddle name
--        ]
