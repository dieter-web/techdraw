module TechDraw.SVG.Path.Parser
  ( parsePath
  ) where

import TechDraw.SVG.Path.Types

parserPath :: [Token] -> [PathCommand]
parserPath [] = []

parserPath (Letter 'M' : Number x : Number y : rest ) =
  MoveTo x y : parsePath rest
parserPath (Letter 'L' : Number x : Number y : rest ) =
  LineTo x y : parsePath rest
parserPath (Letter 'H' : Number x : rest ) =
  HLineTo x : parsePath rest
parserPath (Letter 'V' : Number y : rest ) =
  VLineTo y : parsePath rest
parserPath (Letter 'Z' : rest ) =
  ClosePath : parsePath rest
parsePath (_:rest) =
  parsePath rest
