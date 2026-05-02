-- Cabal-Hook für Kicad
-- Beim Build ruft Cabal automatisch postConf oder preBuild auf.
-- Wir hängen uns in postConf ein und generieren Module.

import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Simple.LocalBuildInfo
import System.Directory
import System.FilePath
import Data.Aeson
import qualified Data.ByteString as BS

import Generator (generateSymbolModule, generateFootprintModule)

main :: IO ()
main = defaultMainWithHooks simpleUserHooks
  { postConf = \arg flags pkgDesc lbi -> do
    putStrLn "==> Importing Kicad 9/10 libraries..."
    runKiCadImport
    postConf simpleUserHooks arg flags pkgDesc lbi
    }

runKiCadImport :: IO ()
runKiCadImport = do
  let symDir = "kicad-libs/symbols"
  let fpDir = "kicad-libs/footprints"
  let outDir = "generated/TechDraw/KiCad"

  createDirectoryIfMissing True outDir

  syms <- listDirectory symDir
  fps <- listDirectory fpDir

  mapM_ (processSymbol symDir outDir) syms
  mapM_ (processFootprint fpDir outDir) fps


processSymbol :: FilePath -> FilePath -> FilePath -> IO ()
processSymbol base out file = do
    let inFile = base </> file
    let outFile = out </> replaceExtension file "hs"

    bs <- BS.readFile inFile
    case eitherDecodeStrict bs of
      Left err -> putStrLn $ "Symbol parse error: " ++ err
      Right sym -> generateSymbolModule outFile sym

processFootprint :: FilePath -> FilePath -> FilePath -> IO ()
processFootprint base out file = do
    let inFile = base </> file
    let outFile = out </> replaceExtension file "hs"

    bs <- BS.readFile inFile
    case eitherDecodeStrict bs of
      Left err -> putStrLn $ "Footprint parse error: " ++ err
      Right fp -> generateFootprintModule outFile fp


