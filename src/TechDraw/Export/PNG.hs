module TechDraw.Export.PNG
  ( exportPNG
  ) where

import TechDraw.Pcb.Types

-- | Placeholder for future PNG export
exportPNG :: FilePath -> [TechElement] -> IO ()
exportPNG path _ = do
  putStrLn $ "PNG export not implemented yet: " ++ path

