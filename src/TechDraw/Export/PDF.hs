module TechDraw.Export.PDF
  ( exportPDF
  ) where

import TechDraw.Pcb.Types

-- | Placeholder for future PDF export
exportPDF :: FilePath -> [TechElement] -> IO ()
exportPDF path _ = do
  putStrLn $ "PDF export not implemented yet: " ++ path

