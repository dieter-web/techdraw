{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
-- Annahme: Multi-Workspace mit
--   techdraw-core
--   techdraw-svg
--   techdraw-electrical
--   techdraw-tools

import TechDraw.Core.Types -- Grundtypen, Units, Layout-DSL
-- SVG-Typen, primitives
-- SVG-Renderer (Model -> Text)
-- elektrische Symbole/Netze
import TechDraw.Electrical.Render -- elektrische Darstellung -> TechDraw.Core
-- import TechDraw.Tools.Export.SVG  -- high-level Export-Funktion(en)
-- ggf. weitere Tools:
-- import TechDraw.Tools.Export.PNG
-- import TechDraw.Tools.Export.PDF
import TechDraw.Electrical.Types
import TechDraw.SVG.Render
import TechDraw.SVG.Types

--------------------------------------------------------------------------------
-- Beispiel: ein kleines Demo-Board als TechDraw-Modell

demoBoard :: Drawing
demoBoard =
  let -- hier dein Layout-DSL aus techdraw-core verwenden
      -- z.B. moduleBox, connector, label, dimension, etc.
      base = emptyDrawing
      board = moduleBox (pt 0 0) (pt 100 80) "Demo-Board"
      conn1 = connector (pt 10 10) "J1"
      conn2 = connector (pt 90 70) "J2"
   in board <> conn1 <> conn2 <> label (pt 50 40) "TechDraw Demo"

--------------------------------------------------------------------------------
-- Beispiel: elektrische Demo-Schaltung

demoCircuit :: ElectricalNet
demoCircuit =
  -- hier deine Electrical-DSL verwenden
  -- z.B. net, resistor, capacitor, opamp, etc.
  net
    "N1"
    [ resistor "R1" 1000,
      capacitor "C1" 1e-6
    ]

--------------------------------------------------------------------------------
-- High-Level: verschiedene Modi über CLI

data Mode
  = ModeSvgDemoBoard FilePath
  | ModeSvgCircuit FilePath
  deriving (Eq, Show)

parseArgs :: [String] -> Either String Mode
parseArgs ["svg-demo-board", out] = Right (ModeSvgDemoBoard out)
parseArgs ["svg-circuit", out] = Right (ModeSvgCircuit out)
parseArgs _ =
  Left
    "Usage:\n\
    \  techdraw-workspace svg-demo-board output.svg\n\
    \  techdraw-workspace svg-circuit    output.svg"

--------------------------------------------------------------------------------
-- Ausführung

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Left err -> do
      hPutStrLn stderr err
      exitFailure
    Right (ModeSvgDemoBoard outFile) -> do
      -- Drawing -> SVG-Text
      let svgText = renderDrawingToSvg demoBoard
      writeFile outFile svgText
    Right (ModeSvgCircuit outFile) -> do
      -- ElectricalNet -> Drawing -> SVG-Text
      let drawing = renderElectricalNet demoCircuit
          svgText = renderDrawingToSvg drawing
      writeFile outFile svgText

--------------------------------------------------------------------------------
-- Hilfsfunktionen (abhängig von deiner tatsächlichen API)

-- Annahme: pt :: Double -> Double -> Point
pt :: Double -> Double -> Point
pt = point

-- Annahme: emptyDrawing, (<>), moduleBox, connector, label usw.
-- kommen aus TechDraw.Core / TechDraw.Elements.*

-- Annahme: renderDrawingToSvg :: Drawing -> String
renderDrawingToSvg :: Drawing -> String
renderDrawingToSvg = svgRender

-- Annahme: renderElectricalNet :: ElectricalNet -> Drawing
renderElectricalNet :: ElectricalNet -> Drawing
renderElectricalNet = electricalRender
