{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module KiCad.Types where

import GHC.Generics
import Data.Aeson

data KiCadPin = KiCadPin
  { number :: String
  , pinName :: String
  , pintType :: String
  } deriving (Show, Eq, Generic, FromJSON)


data KiCadSymbol = KiCadSymbol
  { name :: String
  , properties :: [KiCadProperty]
  , pins :: [KiCadPin]
  } deriving (Show, Eq, Generic, FromJSON)

data KiCadProperty = KiCadProperty
  { key :: String
  , value :: String 
  } deriving (Show, Eq, Generic, FromJSON)

