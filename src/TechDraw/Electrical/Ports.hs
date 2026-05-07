module TechDraw.Electrical.Ports (
    portsOf,
    portsOfSymbol,
) where

import TechDraw.Electrical.Types (Port (..), Symbol (..), SymbolType (..))
import TechDraw.SVG.Types (Pos)

--------------------------------------------------------------
-- 1. Ports pro Symboltyp (alle RELATIV zum zentrieren Symbol)
--------------------------------------------------------------

portsOf :: SymbolType -> [Port]
portsOf t =
    case t of
        -- Widerstände
        Resistor ->
            [ Port "A" (-26, 0) 180
            , Port "B" (26, 0) 0
            ]
        Potentiometer ->
            [ Port "A" (-26, 0) 180
            , Port "B" (26, 0) 0
            , Port "W" (0, -10) 270
            ]
        Trimmer ->
            [ Port "A" (-26, 0) 180
            , Port "B" (26, 0) 0
            , Port "W" (0, -10) 270
            ]
        ThermistorPTC ->
            [ Port "A" (-26, 0) 180
            , Port "B" (26, 0) 0
            ]
        ThermistorNTC ->
            [ Port "A" (-26, 0) 180
            , Port "B" (26, 0) 0
            ]
        -- Kondensatoren
        Capacitor ->
            [ Port "A" (-12, 0) 180
            , Port "B" (12, 0) 0
            ]
        CapacitorPolarized ->
            [ Port "A" (-12, 0) 180
            , Port "B" (12, 0) 0
            ]
        CapacitorVariable ->
            [ Port "A" (-12, 0) 180
            , Port "B" (12, 0) 0
            ]
        CapacitorTrimmer ->
            [ Port "A" (-12, 0) 180
            , Port "B" (12, 0) 0
            ]
        -- Induktivitäten
        Inductor ->
            [ Port "A" (-12, 0) 180
            , Port "B" (28, 0) 0
            ]
        Transformer ->
            [ Port "P1" (-20, -8) 180
            , Port "P2" (4, -8) 0
            , Port "S1" (-20, 8) 180
            , Port "S2" (4, 8) 0
            ]
        -- Schalter
        SwitchOpen ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        SwitchClosed ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        SwitchSPDT ->
            [ Port "A" (-16, 0) 180
            , Port "B1" (16, -6) 0
            , Port "B2" (16, 6) 0
            ]
        SwitchDPDT ->
            [ Port "A1" (-16, -4) 180
            , Port "B1" (16, -10) 0
            , Port "C1" (16, -4) 0
            , Port "A2" (-16, 4) 180
            , Port "B2" (16, 10) 0
            , Port "C2" (16, 4) 0
            ]
        SwitchToggle ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        Switch2P ->
            [ Port "A1" (-16, -4) 180
            , Port "B1" (16, -8) 0
            , Port "A2" (-16, 4) 180
            , Port "B2" (16, 0) 0
            ]
        PushButtonNO ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        PushButtonNC ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        -- Sicherungen
        Fuse ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        FuseHolder ->
            [ Port "A" (-18, 0) 180
            , Port "B" (18, 0) 0
            ]
        FuseThermal ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        CircuitBreaker ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        -- Ground
        Ground ->
            [ Port "GND" (0, -8) 270
            ]
        EarthProtective ->
            [ Port "PE" (0, -8) 270
            ]
        -- Motor / Lampe
        Motor ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        Lamp ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        -- Dioden
        Diode ->
            [ Port "A" (-16, 0) 180
            , Port "K" (16, 0) 0
            ]
        LED ->
            [ Port "A" (-16, 0) 180
            , Port "K" (16, 0) 0
            ]
        Zener ->
            [ Port "A" (-16, 0) 180
            , Port "K" (16, 0) 0
            ]
        -- Transistoren
        TransistorNPN ->
            [ Port "B" (-16, 0) 180
            , Port "C" (16, -8) 0
            , Port "E" (16, 8) 0
            ]
        TransistorPNP ->
            [ Port "B" (-16, 0) 180
            , Port "C" (16, -8) 0
            , Port "E" (16, 8) 0
            ]
        -- OpAmp
        OpAmp ->
            [ Port "+" (-18, -6) 180
            , Port "-" (-18, 6) 180
            , Port "OUT" (18, 0) 0
            ]
        -- Quellen
        Battery ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        DCSource ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        ACSource ->
            [ Port "A" (-16, 0) 180
            , Port "B" (16, 0) 0
            ]
        -- Sonstige
        Connector ->
            [ Port "A" (-12, 0) 180
            , Port "B" (12, 0) 0
            ]
        Terminal ->
            [ Port "A" (-12, 0) 180
            ]

----------------------------------------------------
-- 2. Ports transformieren (Scale, Rotate, Translate)
----------------------------------------------------
--
portsOfSymbol :: Symbol -> [Port]
portsOfSymbol (Symbol t (px, py) rot scale) =
    map transform (portsOf t)
  where
    transform (Port name (x, y) dir) =
        let
            -- 1. Skalieren
            x1 = x * scale
            y1 = y * scale

            -- 2. Rotation
            r = rot * pi / 180
            xr = x1 * cos r - y1 * sin r
            yr = x1 * sin r + y1 * cos r

            -- 3. Verschieben
            xf = xr + px
            yf = yr + py

            -- 4. Richtung drehen
            dir' = dir + rot
         in
            Port name (xf, yf) dir'

--      (xr, yr) = rotate rot (x, y)
--      in Port n (px + xr, py + yr)

-- rotate :: Double -> Pos -> Pos
-- rotate deg (x, y) =
--  let r = deg * pi / 180
--  in ( x * cos r - y * sin r
--     , x * sin r + y * cos r
--     )
--
-- rotatePort :: Symbol -> [Port]
-- rotatePort rot (cx, cy)(Port n (x,y) d) =
--  Port n (rotateAround rot (cx, cy) (x+cx, y+cy))
--
-- rotateAround :: Double -> Pos -> Pos -> Pos
-- rotateAround deg (cx, cy) (x, y) =
--  let r = deg * pi / 180
--      dx = x - cx
--      dy = y - cy
--  in ( cx + dx * cos r - dy * sin r
--     , cy + dx * sin r + dy * cos r
--     )
