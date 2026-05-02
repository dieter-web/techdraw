module Main where

import KiCad.SExprParser
import KiCad.Symbol
import KiCad.SymbolGenerator

import System.Directory
import System.FilePath

main :: IO ()
main = do
  let inDir  = "symbols"
  let outDir = "src/TechDraw/Electrical/Symbols"

  files <- listDirectory inDir
  let symFiles = filter (".kicad_sym" `isExtensionOf`) files

  mapM_ (process inDir outDir) symFiles

process :: FilePath -> FilePath -> FilePath -> IO ()
process inDir outDir file = do
  txt <- readFile (inDir </> file)
  case parseKiCadLibrary txt of
    Left err -> putStrLn ("Parse error in " ++ file ++ ": " ++ err)
    Right lib ->
      mapM_ (generateOne outDir) (libSymbols lib)

generateOne :: FilePath -> KiCadSymbol -> IO ()
generateOne outDir sym = do
  let outFile = outDir </> symName sym <.> "hs"
  generateSymbolModule outFile sym
  putStrLn ("Generated: " ++ outFile)
