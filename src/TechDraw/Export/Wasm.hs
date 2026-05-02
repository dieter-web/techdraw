module TechDraw.Export.Wasm
  ( exportWasm
  ) where

import TechDraw.Pcb.Types

-- | Placeholder for future WASM export
exportWasm :: FilePath -> [TechElement] -> IO ()
exportWasm path _ = do
  putStrLn $ "WASM export not implemented yet: " ++ path

