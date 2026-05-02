module TechDraw.SVG.Matrix
  ( Mat3
  , matIdentity
  , matMul
  , matTranslate
  , matScale
  , matRotate
  , toMat3
  , combineTransforms
  , toSvgMatrix
  ) where

import TechDraw.SVG (Transform(..))
import TechDraw.SVG.Types (Pos)

type Mat3 =
  ( (Double, Double, Double)
  , (Double, Double, Double)
  , (Double, Double, Double)
  )

matIdentity :: Mat3
matIdentity =
  ( (1,0,0)
  , (0,1,0)
  , (0,0,1)
  )

matMul :: Mat3 -> Mat3 -> Mat3
matMul ( (a11, a12, a13)
       , (a21, a22, a23)
       , (a31, a32, a33)
       )
       ( (b11, b12, b13)
       , (b21, b22, b23)
       , (b31, b32, b33)
       ) =
  ( (a11*b11 + a12*b21 + a13*b31,
     a11*b12 + a12*b22 + a13*b32,
     a11*b13 + a12*b23 + a13*b33)
  , (a21*b11 + a22*b21 + a23*b31,
     a21*b12 + a22*b22 + a23*b32,
     a21*b13 + a22*b23 + a23*b33)
  , (a31*b11 + a32*b21 + a33*b31,
     a31*b12 + a32*b22 + a33*b32,
     a31*b13 + a32*b23 + a33*b33)
  )

matTranslate :: Double -> Double -> Mat3
matTranslate tx ty =
  ( (1,0,tx)
  , (0,1,ty)
  , (0,0,1)
  )

matScale :: Double -> Double -> Mat3
matScale sx sy =
  ( (sx, 0, 0)
  , (0, sy, 0)
  , (0, 0,  1)
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
  , _           -- (0,0,1)
  ) =
    "matrix(" ++ unwords (map show [a,b,c,d,e,f]) ++ ")"



