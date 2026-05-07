module TechDraw.SVG.Path.Render (renderPathCommand)
where

import TechDraw.SVG.Paths

renderPathCommand :: PathCommand -> String
renderPathCommand cmd = case cmd of
    MoveTo x y ->
        "M " ++ show x ++ " " ++ show y
    MoveToRel x y ->
        "m " ++ show x ++ " " ++ show y
    LineTo x y ->
        "L " ++ show x ++ " " ++ show y
    LineToRel x y ->
        "l " ++ show x ++ " " ++ show y
    HLineTo x ->
        "H " ++ show x
    HLineToRel dx ->
        "h " ++ show dx
    VLineTo y ->
        "V " ++ show y
    VLineToRel dy ->
        "v " ++ show dy
    CubicTo x1 y1 x2 y2 x y ->
        "C "
            ++ show x1
            ++ " "
            ++ show y1
            ++ " "
            ++ show x2
            ++ " "
            ++ show y2
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    CubicToRel x1 y1 x2 y2 x y ->
        "c "
            ++ show x1
            ++ " "
            ++ show y1
            ++ " "
            ++ show x2
            ++ " "
            ++ show y2
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    SmoothCubicTo x2 y2 x y ->
        "S "
            ++ show x2
            ++ " "
            ++ show y2
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    SmoothCubicToRel x2 y2 x y ->
        "s "
            ++ show x2
            ++ " "
            ++ show y2
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    QuadTo cx cy x y ->
        "Q "
            ++ show cx
            ++ " "
            ++ show cy
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    QuadToRel cx cy x y ->
        "q "
            ++ show cx
            ++ " "
            ++ show cy
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    SmoothQuadTo x y ->
        "T " ++ show x ++ " " ++ show y
    SmoothQuadToRel x y ->
        "t " ++ show x ++ " " ++ show y
    ArcTo rx ry rot large sweep x y ->
        "A "
            ++ show rx
            ++ " "
            ++ show ry
            ++ " "
            ++ show rot
            ++ " "
            ++ flag large
            ++ " "
            ++ flag sweep
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    ArcToRel rx ry rot large sweep x y ->
        "a "
            ++ show rx
            ++ " "
            ++ show ry
            ++ " "
            ++ show rot
            ++ " "
            ++ flag large
            ++ " "
            ++ flag sweep
            ++ " "
            ++ show x
            ++ " "
            ++ show y
    ClosePath ->
        "Z"
    ClosePathRel ->
        "z"
  where
    flag True = "1"
    flag False = "0"
