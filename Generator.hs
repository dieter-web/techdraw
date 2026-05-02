-- Module-Generator
-- Dieser Teil erzeugt echte Haskell-Module aus JSON-Daten.

module Generator where

import System.IO
import KiCad.Types
import KiCad.Footprint

generateSymbolModule :: FilePath -> KiCadSymbol -> IO ()
generateSymbolModule out sym = do
  writeFile out $
    "module TechDraw.KiCad." ++ sanitize (name sym) ++ " where\n\n" ++
    "import TechDraw.KiCad.Types\n\n" ++
    "symbol :: KicadSymbol\n" ++
    "symbol = " ++ show sym ++ "\n"

generateFootprintModule :: FilePath -> KiCadFootprint -> IO ()
generateFootprintModule out fp = do
  writeFile out $
    "module TechDraw.KiCad." ++ sanitize (fpName fp) ++ " where\n\n" ++
    "import TechDraw.KiCad.Types\n\n" ++
    "footprint :: KiCadFootprint\n" ++
    "footprint = " ++ show fp ++ "\n"

sanitize :: String -> String
sanitize = map (\c -> if c `elem` ":.- " then '_' else c)
