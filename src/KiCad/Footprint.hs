{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module KiCad.Footprint
  ( KiCadFootprint(..)
  ) where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON, ToJSON)


data KiCadFootprint = KiCadFootprint
  { fpName :: String
  , fpPads :: [String] -- später: eigener Pad-Typ
  , fpGraphics :: [String] -- später: Linien, Kreise, Texte
  }
  deriving(Show,Eq, Generic, FromJSON, ToJSON)
