module TechDraw.Electrical.Types (
    Port (..),
    Pin (..),
    Symbol (..),
    Wire (..),
    Electrical (..),
    SymbolType (..),
)
where

import TechDraw.SVG
import TechDraw.SVG.Types

type PortName = String

data Port = Port
    { portName :: PortName
    , portPos :: Pos -- relative Position zum zentrischen Symbol
    , portDir :: Double -- Richtung in Grad (0 = rechts, 90 = oben)
    }
    deriving (Eq, Show)

data Pin = Pin
    { pinName :: String
    , pinPos :: Pos
    }
    deriving (Eq, Show)

-- Beispiel Symbol erzeugen: Symbol Capacitor(200,150) 45 1.5
data Symbol = Symbol
    { symType :: SymbolType
    , symPos :: Pos
    , symRot :: Double
    , symScale :: Double
    }
    deriving (Eq, Show)

-- Das ist bewusst minimal - später können wir
-- Wire-Stile, orthogonales Routing, automatische Knicke, Netzlisten, Labels
-- hinzufügen
--
data Wire = Wire
    { wireFrom :: Port
    , wireTo :: Port
    }
    deriving (Eq, Show)

data Electrical = Electrical
    { symbols :: [Symbol]
    , wires :: [Wire]
    }
    deriving (Eq, Show)

data SymbolType
    = Resistor
    | Potentiometer
    | Trimmer
    | ThermistorPTC
    | ThermistorNTC
    | Capacitor
    | CapacitorPolarized
    | CapacitorVariable
    | CapacitorTrimmer
    | Inductor
    | Transformer
    | SwitchOpen -- Switches
    | SwitchClosed
    | SwitchSPDT
    | SwitchDPDT
    | SwitchToggle
    | Switch2P
    | PushButtonNO
    | PushButtonNC
    | Fuse
    | FuseHolder
    | FuseThermal
    | CircuitBreaker
    | Ground
    | EarthProtective
    | Motor
    | Lamp
    | Diode
    | LED
    | Zener
    | TransistorNPN
    | TransistorPNP
    | OpAmp
    | Battery
    | DCSource
    | ACSource
    | Connector
    | Terminal
    deriving (Eq, Show)
