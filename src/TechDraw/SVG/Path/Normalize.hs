-- file: src/TechDraw/SVG/Path/Normalize.hs
module TechDraw.SVG.Path.Normalize
  ( normalizePath
  ) where

import TechDraw.SVG.Path.Types

-- Dummy-Normalizer (kann später erweitert werden)
normalizePath :: [PathCommand] -> [PathCommand]
normalizePath = id
