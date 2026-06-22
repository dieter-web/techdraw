{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Core.Style
  ( Stroke (..),
    Fill (..),
    Color (..),
    Style (..),
    defaultStroke,
    defaultFill,
  )
where

import Data.Text (Text)

data Stroke = Stroke
  { strokeColor :: Text,
    strokeWidth :: Double
  }
  deriving (Show, Eq)

defaultStroke :: Stroke
defaultStroke = Stroke "black" 1

data Fill
  = FillNone
  | FillColor Color
  deriving (Show, Eq)

defaultFill :: Fill
defaultFill = FillNone

data Color
  = Named Text
  | RGB Int Int Int
  deriving (Show, Eq)

{-
Diagnostics:
1. Use newtype instead of data
   Found:
     data Fill
     = Fill {fillColor :: Text}
     deriving (Show, Eq)
   Why not:
     newtype Fill
     = Fill {fillColor :: Text}
     deriving (Show, Eq)
   decreases laziness
    [Use newtype instead of data]
-}

-- data Style = Style
--  { styleStroke :: Maybe Stroke,
--    styleFill :: Maybe Fill
--  }
--  deriving (Show, Eq)
data Style = Style
  { styleStroke :: Maybe (Color, Double),
    styleFill :: Maybe Color
  }

-- defaultStyle :: Style
-- defaultStyle =
--  Style
--    { styleStroke = Just (Stroke "#000000" 1.0),
--      styleFill = Nothing
--    }
