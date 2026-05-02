module TechDraw.Pcb.Render
  ( Renderable(..)
  ) where

import TechDraw.Pcb.Types

-- | A typeclass for render backends (SVG, PNG, PDF, WASM)
class Renderable a where
  render :: a -> [TechElement] -> IO ()

