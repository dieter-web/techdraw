module TechDraw.Electrical.Render (
    renderElectrical,
    renderSym,
    renderWire,
    connect,
    lookupPort,
) where

import TechDraw.SVG
import TechDraw.SVG.Defaults

-- import TechDraw.SVG.Render
import TechDraw.SVG.Util

-- import TechDraw.SVG.Types

-- liefert renderSymbolBase
import Data.List (find)
import TechDraw.Electrical.Ports (portsOfSymbol)

import TechDraw.Electrical.Symbols
import TechDraw.Electrical.Types (Electrical (..), Port (..), Symbol (..), Wire (..))

renderElectrical :: Electrical -> SVG
renderElectrical (Electrical syms wires) =
    Group (map renderSym syms ++ map renderWire wires)

renderSym :: Symbol -> SVG
renderSym (Symbol t pos rot scale) =
    translate pos $
        rotateAround rot (0, 0) $
            scaleUniform scale $
                renderSymbol t (0, 0)

-- renderSym :: Symbol -> SVG
-- renderSym (Symbol t (px, py) rot scale) =
--    Transform
--        ( TransformList
--            [ Scale scale scale
--            , Rotate rot (0, 0)
--            , Translate px py
--            ]
--        )
--        (renderSymbol t (0, 0))

-- Alternative
-- renderSym (Symbol t (px, py) rot scale) =
--    Transform
--        (Translate px py)
--        ( Transform
--            (Rotate rot (0, 0))
--            ( Transform
--                (Scale scale scale)
--                ( renderSymbol t (0, 0)
--                )
--            )
--        )

-- renderSym :: Symbol -> SVG
-- renderSym (Symbol t pos rot scale) =
--    Transform (Translate (fst pos) (snd pos)) $
--        Transform (Rotate rot (0, 0)) $
--            Transform (Scale scale scale) $
--                renderSymbol t (0, 0)

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

-- portsOfSymbol :: Symbol -> [Port]
-- portsOfSymbol sym@(Symbol t _ _ _) =
--    map (transformPort sym) (portsOf t)

-- portsOfSymbol :: Symbol -> [Port]
-- steht in TechDraw.Electrical.Ports
-- portsOfSymbol (Symbol t (px, py) rot scale) =
--    map transform (portsOf t)
--  where
--    transform (Port name (x, y) dir) =
--        let
--            x1 = x * scale
--            y1 = y * scale
--            r = rot * pi / 180
--            xr = x1 * cos r - y1 * sin r
--            yr = x1 * sin r + y1 * cos r
--         in
--            Port name (px + xr, py + yr) (dir + rot)

renderWire :: Wire -> SVG
renderWire (Wire (Port _ p1 _) (Port _ p2 _)) =
    Line p1 p2 strokeDefault -- strokeDefault aus Defaults-Modul

-- 10.3: Wire aus zwei Symbolen erzeugen
connect :: Symbol -> String -> Symbol -> String -> Wire
connect s1 n1 s2 n2 =
    let ps1 = portsOfSymbol s1
        ps2 = portsOfSymbol s2
        Just p1 = lookupPort n1 ps1
        Just p2 = lookupPort n2 ps2
     in Wire p1 p2

renderWireOrtho :: Wire -> SVG
renderWireOrtho (Wire (Port _ (x1, y1) _) (Port _ (x2, y2) _)) =
    let mid = (x2, y1) -- horizontal, dann vertikal
     in Group
            [ Line (x1, y1) mid strokeDefault
            , Line mid (x2, y2) strokeDefault
            ]

-- Damit kannst du später schreiben connect sym1 "A" sym2 "B"

lookupPort :: String -> [Port] -> Maybe Port
lookupPort name = find ((== name) . portName)

-- lookupPort name = find (\p -> portName p == name)
