module TechDraw.Pcb.Types where

import TechDraw.SVG.Types

-- | 2D-Punkt

data Point = Point
  { px :: Double
  , py :: Double
  } deriving(Show, Eq)

data PadShape = RoundPad | RectPad | RoundRectPad
    deriving (Show, Eq)

-- | Zentrales Element deiner TechDraw-Darstellung

data TechElement
  = EModuleBox
    { mbPos :: Point
    , mbWidth :: Double
    , mbHeight :: Double
    , mbLabel :: String 
    }
  | EConnector
      { connStart :: Point
      , connEnd   :: Point
      , connName :: String 
      }
  | EMountHole
      { mhCenter :: Point
      , mhDiameter :: Double 
      }
  | EDimension
      { dimStart :: Point
      , dimEnd :: Point
      , dimText :: String
      }
  | ELabel
      { labelPos  :: Point
      , labelText :: String 
      }
  | EGroup
      { children :: [TechElement] 
      }
  | ELayer String [TechElement]

  -- PCB Pads
  | EPad Point Double Double PadShape String   -- pos, w, h, shape, name

  -- PCB Routing (Kupferbahnen)
  | ETrace [Point] Double                      -- polyline, width

  -- Silkscreen
  | ESilkLine Point Point
  | ESilkText Point String
  | ESilkCircle Point Double
  deriving (Show, Eq)

-- Style

data Style = Style
  { strokeColor :: String
  , strokeWidth :: Double
  , fillColor   :: String
  , fontSize    :: Double
  } deriving (Show, Eq)

defaultStyle :: Style
defaultStyle = Style
  { strokeColor = "black"
  , strokeWidth = 0.5
  , fillColor   = "none"
  , fontSize    = 12
  }

data Theme = Theme
  { colorBoard     :: String
  , colorCopper    :: String
  , colorSilk      :: String
  , colorDrill     :: String
  , colorDimension :: String
  } deriving (Show, Eq)

defaultTheme :: Theme
defaultTheme = Theme
  { colorBoard = "white"
  , colorCopper = "black"
  , colorSilk = "black"
  , colorDrill = "black"
  ,colorDimension = "blue"
  }

pcbTheme :: Theme
pcbTheme = Theme
  { colorBoard     = "#0a5c0a"   -- dunkles PCB-Grün
  , colorCopper    = "#d4af37"   -- gold
  , colorDrill     = "#222222"
  , colorDimension = "cyan"
  , colorSilk      = "white"
  }



