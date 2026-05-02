{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module KiCad.Symbol
  ( KiCadSymbol(..)
  , KiCadGraphic(..)
  , KiCadPoint(..)
  ) where

data KiCadPoint = KiCadPoint
  { px :: Double
  , py :: Double
  }
  deriving (Show, Eq)

data KiCadGraphic
  = Polyline [KiCadPoint]
  | Circle KiCadPoint Double
  | Arc KiCadPoint KiCadPoint KiCadPoint Double
  | Rect KiCadPoint KiCadPoint
  | Text KiCadPoint Double String  -- pos, rotation, text
  | Pin
     { pinPos    :: KiCadPoint
     , pinAngle  :: Double
     , pinLenth  :: Double
     , pinName   :: String
     , pinNumber :: String
     }
  deriving (Show, Eq)

data KiCadSymbol = KiCadSymbol
  { symName     :: String
  , symGraphics :: [KiCadGraphic]
  }
  deriving (Show, Eq)
