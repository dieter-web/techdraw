module TechDraw.SVG.Matrix (
    Mat3,
    matIdentity,
    matTranslate,
    matScale,
    matRotate,
    matMul,
    toMat3,
    combineTransforms,
    toSvgMatrix,
) where

import TechDraw.SVG.Types (Pos, Transform (..))

type Mat3 =
    ( (Double, Double, Double)
    , (Double, Double, Double)
    , (Double, Double, Double)
    )

matIdentity :: Mat3
matIdentity =
    ( (1, 0, 0)
    , (0, 1, 0)
    , (0, 0, 1)
    )

matMul :: Mat3 -> Mat3 -> Mat3
matMul
    ( (a1, b1, c1)
        , (d1, e1, f1)
        , (g1, h1, i1)
        )
    ( (a2, b2, c2)
        , (d2, e2, f2)
        , (g2, h2, i2)
        ) =
        (
            ( a1 * a2 + b1 * d2 + c1 * g2
            , a1 * b2 + b1 * e2 + c1 * h2
            , a1 * c2 + b1 * f2 + c1 * i2
            )
        ,
            ( d1 * a2 + e1 * d2 + f1 * g2
            , d1 * b2 + e1 * e2 + f1 * h2
            , d1 * c2 + e1 * f2 + f1 * i2
            )
        ,
            ( g1 * a2 + h1 * d2 + i1 * g2
            , g1 * b2 + h1 * e2 + i1 * h2
            , g1 * c2 + h1 * f2 + i1 * i2
            )
        )

matTranslate :: Double -> Double -> Mat3
matTranslate tx ty =
    ( (1, 0, tx)
    , (0, 1, ty)
    , (0, 0, 1)
    )

matScale :: Double -> Double -> Mat3
matScale sx sy =
    ( (sx, 0, 0)
    , (0, sy, 0)
    , (0, 0, 1)
    )

matRotate :: Double -> Mat3
matRotate deg =
    let r = deg * pi / 180
        c = cos r
        s = sin r
     in ( (c, -s, 0)
        , (s, c, 0)
        , (0, 0, 1)
        )

toMat3 :: Transform -> Mat3
toMat3 (Translate tx ty) =
    matTranslate tx ty
toMat3 (Scale sx sy) =
    matScale sx sy
toMat3 (Rotate deg (cx, cy)) =
    -- Rotation um Punkt (cx,cy):
    -- T(cx,cy) * R(deg) * T(-cx,cy)
    matTranslate cx cy
        `matMul` matRotate deg
        `matMul` matTranslate (-cx) (-cy)

-- Liste von Transformationen kombinieren
--
combineTransforms :: [Transform] -> Mat3
combineTransforms trs =
    foldl matMul matIdentity (map toMat3 trs) -- fodl = Transformationen in der Reihenfolge anwenden
    -- matMul = Matrixmultiplikation
    -- matIdentity = Startwert

-- Matrix -> SVG-matrix(a b c d e f)
toSvgMatrix :: Mat3 -> String
toSvgMatrix
    ( (a, c, e)
        , (b, d, f)
        , _ -- (0,0,1)
        ) =
        "matrix(" ++ unwords (map show [a, b, c, d, e, f]) ++ ")"
