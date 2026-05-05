module TechDraw.Electrical.Render (
    renderElectrical,
    renderSym,
    renderWire,
    connect,
    lookupPort,
) where

import TechDraw.SVG
import TechDraw.SVG.Defaults
import TechDraw.SVG.Render

-- import TechDraw.SVG.Types

-- liefert renderSymbolBase
import Data.List (find)
import TechDraw.Electrical.Symbols
import TechDraw.Electrical.Types (Electrical (..), Port (..), Symbol (..), Wire (..))

renderElectrical :: Electrical -> SVG
renderElectrical (Electrical syms wires) =
    Group (map renderSym syms ++ map renderWire wires)

renderSym :: Symbol -> SVG
renderSym (Symbol t pos rot scale) =
    Transform (Translate (fst pos) (snd pos)) $
        Transform (Rotate rot (0, 0)) $
            Transform (Scale scale scale) $
                renderSymbol t (0, 0)

-- renderSym :: Symbol -> SVG
-- renderSym (Symbol t(px,py) rot scale) =
--  Transform (Translate px py) $
--    Transform (Rotate rot (0,0)) $
--      Transform (Scale scale scale) $
--        renderSymbol t (0,0)

-- renderSym (Symbol t(px,py) rot scale) =
--  Transform
--    [ Scale scale scale
--    , Rotate rot (0,0)
--    , Translate px py
--    ]
--    (renderSymbol t (0,0))

-- Ports transformieren wie das Symbol
transformPort :: Symbol -> Port -> Port
transformPort (Symbol _ (px, py) rot scale) (Port name (x, y) dir) =
    let
        -- 1. Skalieren
        x1 = x * scale
        y1 = y * scale

        -- 2. Rotieren
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

portsOfSymbol :: Symbol -> [Port]
portsOfSymbol sym@(Symbol t _ _ _) =
    map (transformPort sym) (portsOf t)

-- renderSym (Symbol t pos rot scale) =
--  translate pos $
--    rotateAround rot (0,0) $
--      scaleUniform scale $
--        renderSymbol t(0,0)

renderWire :: Wire -> SVG
renderWire (Wire (Port _ p1 _) (Port _ p2 _)) =
    Line p1 p2 strokeDefault

-- 10.3: Wire aus zwei Symbolen erzeugen
connect :: Symbol -> String -> Symbol -> String -> Wire
connect symA portNameA symB portNameB =
    let portsA = portsOfSymbol symA
        portsB = portsOfSymbol symB
        Just pA = lookupPort portNameA portsA
        Just pB = lookupPort portNameB portsB
     in Wire pA pB

-- Damit kannst du später schreiben connect sym1 "A" sym2 "B"

lookupPort :: String -> [Port] -> Maybe Port
lookupPort name = find (\p -> portName p == name)
