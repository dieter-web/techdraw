module TechDraw.Export.SVG
  ( renderSVG
  ) where

import TechDraw.Pcb.Types

-- | SVG header + body
renderSVG :: Theme -> [TechElement] -> String
renderSVG theme elems =
  "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\n"
  ++ concatMap (renderElementSVG theme) elems
  ++ "</svg>\n"

-- | Render a single element
renderElementSVG :: Theme -> TechElement -> String

-- PCB outline / module box
renderElementSVG theme (EModuleBox (Point x y) w h lbl) =
  "<g class=\"module-box\">\n"
  ++ "  <rect x=\"" ++ show x ++ "\" y=\"" ++ show y ++
     "\" width=\"" ++ show w ++ "\" height=\"" ++ show h ++
     "\" fill=\"" ++ colorBoard theme ++
     "\" stroke=\"" ++ colorSilk theme ++ "\" stroke-width=\"1\" />\n"
  ++ "  <text x=\"" ++ show (x + 5) ++ "\" y=\"" ++ show (y + 15)
     ++ "\" fill=\"" ++ colorSilk theme ++ "\" font-size=\"1.2\">" ++ lbl ++ "</text>\n"
  ++ "</g>\n"

-- Connector (copper trace)
renderElementSVG theme (EConnector (Point x1 y1) (Point x2 y2) name) =
  "<g class=\"connector\">\n"
  ++ "  <line x1=\"" ++ show x1 ++ "\" y1=\"" ++ show y1 ++
     "\" x2=\"" ++ show x2 ++ "\" y2=\"" ++ show y2 ++
     "\" stroke=\"" ++ colorCopper theme ++ "\" stroke-width=\"2\" />\n"
  ++ "  <text x=\"" ++ show ((x1+x2)/2) ++ "\" y=\"" ++ show ((y1+y2)/2)
     ++ "\" fill=\"" ++ colorSilk theme ++ "\" font-size=\"1.0\">" ++ name ++ "</text>\n"
  ++ "</g>\n"

-- Drill hole
renderElementSVG theme (EMountHole (Point x y) d) =
  "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y ++
  "\" r=\"" ++ show (d/2) ++
  "\" fill=\"" ++ colorDrill theme ++ "\" stroke=\"none\" />\n"

-- Dimension line
renderElementSVG theme (EDimension (Point x1 y1) (Point x2 y2) txt) =
  "<g class=\"dimension\">\n"
  ++ "  <line x1=\"" ++ show x1 ++ "\" y1=\"" ++ show y1 ++
     "\" x2=\"" ++ show x2 ++ "\" y2=\"" ++ show y2 ++
     "\" stroke=\"" ++ colorDimension theme ++ "\" stroke-width=\"1\" />\n"
  ++ "  <text x=\"" ++ show ((x1+x2)/2) ++ "\" y=\"" ++ show ((y1+y2)/2)
     ++ "\" fill=\"" ++ colorDimension theme ++ "\" font-size=\"1.0\">" ++ txt ++ "</text>\n"
  ++ "</g>\n"

-- Label
renderElementSVG theme (ELabel (Point x y) txt) =
  "<text x=\"" ++ show x ++ "\" y=\"" ++ show y ++
  "\" fill=\"" ++ colorSilk theme ++ "\" font-size=\"1.2\">" ++ txt ++ "</text>\n"

-- Group
renderElementSVG theme (EGroup elems) =
  "<g class=\"group\">\n"
  ++ concatMap (renderElementSVG theme) elems
  ++ "</g>\n"

-- Pads
renderElementSVG theme (EPad (Point x y) w h shape name) =
  case shape of
    RoundPad ->
      "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y ++
      "\" r=\"" ++ show (w/2) ++
      "\" fill=\"" ++ colorCopper theme ++ "\" />\n"

    RectPad ->
      "<rect x=\"" ++ show (x - w/2) ++ "\" y=\"" ++ show (y - h/2) ++
      "\" width=\"" ++ show w ++ "\" height=\"" ++ show h ++
      "\" fill=\"" ++ colorCopper theme ++ "\" />\n"

    RoundRectPad ->
      "<rect x=\"" ++ show (x - w/2) ++ "\" y=\"" ++ show (y - h/2) ++
      "\" width=\"" ++ show w ++ "\" height=\"" ++ show h ++
      "\" rx=\"" ++ show (min w h / 4) ++ "\" ry=\"" ++ show (min w h / 4) ++
      "\" fill=\"" ++ colorCopper theme ++ "\" />\n"

-- Kupfer-Routing (Trace)
renderElementSVG theme (ETrace pts width) =
  "<polyline points=\"" ++ concatMap (\(Point x y) -> show x ++ "," ++ show y ++ " ") pts ++
  "\" fill=\"none\" stroke=\"" ++ colorCopper theme ++
  "\" stroke-width=\"" ++ show width ++ "\" />\n"

-- Silkscreen-Linien
renderElementSVG theme (ESilkLine (Point x1 y1) (Point x2 y2)) =
  "<line x1=\"" ++ show x1 ++ "\" y1=\"" ++ show y1 ++
  "\" x2=\"" ++ show x2 ++ "\" y2=\"" ++ show y2 ++
  "\" stroke=\"" ++ colorSilk theme ++ "\" stroke-width=\"1\" />\n"

-- Silkscreen-Text
renderElementSVG theme (ESilkText (Point x y) txt) =
  "<text x=\"" ++ show x ++ "\" y=\"" ++ show y ++
  "\" fill=\"" ++ colorSilk theme ++ "\" font-size=\"10\">" ++ txt ++ "</text>\n"

-- Silkscreen-Kreis
renderElementSVG theme (ESilkCircle (Point x y) r) =
  "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y ++
  "\" r=\"" ++ show r ++
  "\" fill=\"none\" stroke=\"" ++ colorSilk theme ++ "\" stroke-width=\"1\" />\n"
