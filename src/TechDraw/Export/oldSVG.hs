module TechDraw.Export.SVG 
  ( renderSVG
  , renderElementSVG
  ) where

import Diagramms.Prelude
import Diagramms.Backend.SVG
import TechDraw.Render

exportSVG :: FilePath -> TechElement -> IO ()
exportSVG fp el = renderSVG fp (mkWidth 800) (render el)

