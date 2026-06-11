
{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Core.Style 
  ( Stroke (..)
  , Fill (..)
  , Style (..)
  , defaultStroke
  , defaultStyle
  )
  where

import Data.Text(Text)

data Stroke = Stroke
  { strokeColor :: Text
  , strokeWidth :: Double
  } deriving (Show, Eq)
  
defaultStroke :: Stroke
defaultStroke = Stroke "black" 1

data Fill = Fill
  { fillColor :: Text
  } deriving (Show,Eq)

data Style = Style
  { styleStroke :: Maybe Stroke
  , styleFill   :: Maybe Fill
  } deriving (Show, Eq)

defaultStyle :: Style
defaultStyle = Style
  { styleStroke = Just (Stroke "#000000" 1.0)
  , styleFill   = Nothing
  }
