module TechDraw.Electrical.AllSymbols (allSymbols)
where

import TechDraw.SVG (SVG)

-- Beispiel: bitte an deine echten Module anpassen

import TechDraw.Electrical.Symbols.Capacitor (renderCapacitor)
import TechDraw.Electrical.Symbols.Ground (renderGround)
import TechDraw.Electrical.Symbols.Inductor (renderInductor)
import TechDraw.Electrical.Symbols.Lamp (renderLamp)
import TechDraw.Electrical.Symbols.Resistor (renderResistor)

-- import TechDraw.Electrical.Symbols.Switch (renderSwitch)

-- usw. – alle Symbolmodule hier importieren

-- | Liste aller Symbole für Tests (Rotation, BoundingBox, Ports)
allSymbols :: [(String, SVG)]
allSymbols =
    [ ("Resistor", renderResistor (0, 0))
    , ("Capacitor", renderCapacitor (0, 0))
    , ("Inductor", renderInductor (0, 0))
    , --    , ("Switch", renderSwitch)
      ("Lamp", renderLamp (0, 0))
    , ("Ground", renderGround (0, 0))
    -- hier alle weiteren Symbole eintragen
    ]
