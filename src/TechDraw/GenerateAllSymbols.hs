module TechDraw.GenerateAllSymbols where

import KiCad.Symbol
import TechDraw.SymbolGenerator

import qualified Data.ByteString as BS
import Data.Aeson (eitherDecodeStrict)
import System.FilePath

generateSymbolFromJson :: FilePath -> FilePath -> IO ()
generateSymbolFromJson inFile outDir = do
  bs <- BS.readFile inFile
  case eitherDecodeStrict bs of
    Left err -> putStrLn ("Symbol parse error: " ++ err)
    Right sym -> do
      let outFile = outDir </> symName sym <.> "hs"
      generateSymbolModule outFile sym
