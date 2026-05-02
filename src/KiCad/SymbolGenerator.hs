module KiCad.SymbolGenerator
  ( generateSymbolModule
  ) where

import KiCad.Symbol

generateSymbolModule :: FilePath -> KiCadSymbol -> IO ()
generateSymbolModule out sym =
  writeFile out (generateHaskellModule sym)

generateHaskellModule :: KiCadSymbol -> String
generateHaskellModule sym =
  unlines
    [ "module TechDraw.Electrical.Symbols." ++ symName sym ++ " where"
    , ""
    , "import TechDraw.SVG"
    , ""
    , "render" ++ symName sym ++ " :: Point -> SVG"
    , "render" ++ symName sym ++ " (x,y) = Group"
    , "  ["
    , unlines (map ("    " ++) (map renderGraphic (symGraphics sym)))
    , "  ]"
    ]

renderGraphic :: KiCadGraphic -> String
renderGraphic g = case g of
  Polyline pts ->
    "Polyline [" ++ concatMap renderPt pts ++ "] stroke"
  Circle (KiCadPoint cx cy) r ->
    "Circle (x+" ++ show cx ++ ", y+" ++ show cy ++ ") " ++ show r ++ " stroke"
  Arc (KiCadPoint cx cy) r s e ->
    "Arc (x+" ++ show cx ++ ", y+" ++ show cy ++ ") " ++ show r ++ " " ++ show s ++ " " ++ show e ++ " stroke"

renderPt :: KiCadPoint -> String
renderPt (KiCadPoint x y) =
  "(x+" ++ show x ++ ", y+" ++ show y ++ "), "
