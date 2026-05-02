module TechDraw.SVG.Defaults
  ( strokeDefault
  , fillNone
  )where

import TechDraw.SVG

strokeDefault :: Maybe Stroke
strokeDefault = Just (StrokeColor "black" 0.3)

fillNone :: Fill
fillNone = FillNone
