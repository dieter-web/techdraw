-- {-# LANGUAGE OverloadedStrings #-}

module TechDraw.Core.Transform
  ( Transform (..),
    Mat3 (..),
    identity,
    multiply,
    toMat3,
    -- translate,

    -- rotate
    scale,
    combineTransforms,
    -- transformPoint,
    -- transformShape,
    -- orientationVector,
  )
where

-- import TechDraw.Core.Types

import TechDraw.Core.Vec

-- ============================================================
-- Transformationsbeschreibung
-- ============================================================

data Transform
  = Translate Double Double
  | Rotate Double
  | Scale Double Double
  deriving (-- | Matrix6 Double Double Double Double Double Double
            Eq, Show)

-- ============================================================
-- 3x3 Matrix
-- ============================================================

data Mat3 = Mat3
  { m00 :: !Double,
    m01 :: !Double,
    m02 :: !Double,
    m10 :: !Double,
    m11 :: !Double,
    m12 :: !Double,
    m20 :: !Double,
    m21 :: !Double,
    m22 :: !Double
  }
  deriving (Eq, Show)

identity :: Mat3
identity =
  Mat3
    1
    0
    0
    0
    1
    0
    0
    0
    1

-- ============================================================
-- Transform → Matrix
-- ============================================================

toMat3 :: Transform -> Mat3
toMat3 (Translate dx dy) =
  Mat3
    1
    0
    dx
    0
    1
    dy
    0
    0
    1
toMat3 (Rotate a) =
  let c = cos a
      s = sin a
   in Mat3
        c
        (-s)
        0
        s
        c
        0
        0
        0
        1
toMat3 (Scale sx sy) =
  Mat3
    sx
    0
    0
    0
    sy
    0
    0
    0
    1

multiply :: Mat3 -> Mat3 -> Mat3
multiply a b =
  Mat3
    (m00 a * m00 b + m01 a * m10 b + m02 a * m20 b)
    (m00 a * m01 b + m01 a * m11 b + m02 a * m21 b)
    (m00 a * m02 b + m01 a + m12 b + m02 a + m22 b)
    (m10 a * m00 b + m11 a * m10 b + m12 a * m20 b)
    (m10 a * m01 b + m11 a * m11 b + m12 a * m21 b)
    (m10 a * m02 b + m11 a * m12 b + m12 a * m22 b)
    (m20 a * m00 b + m21 a * m10 b + m22 a * m20 b)
    (m20 a * m01 b + m21 a * m11 b + m22 a * m21 b)
    (m20 a * m02 b + m21 a * m12 b + m22 a * m22 b)

applyMat3 :: Mat3 -> Vec -> Vec
applyMat3 m (Vec x y) =
  Vec
    (m00 m * x + m01 m * y + m02 m)
    (m10 m * x + m11 m * y + m12 m)

-- ============================================================
-- Matrixkombination
-- ============================================================

combineTransforms :: [Transform] -> Mat3
combineTransforms = foldl mul identity . map toMat3
  where
    mul
      ( Mat3
          a11
          a12
          a13
          a21
          a22
          a23
          a31
          a32
          a33
        )
      ( Mat3
          b11
          b12
          b13
          b21
          b22
          b23
          b31
          b32
          b33
        ) =
        Mat3
          (a11 * b11 + a12 * b21 + a13 * b31)
          (a11 * b12 + a12 * b22 + a13 * b32)
          (a11 * b13 + a12 * b23 + a13 * b33)
          (a21 * b11 + a22 * b21 + a23 * b31)
          (a21 * b12 + a22 * b22 + a23 * b32)
          (a21 * b13 + a22 * b23 + a23 * b33)
          (a31 * b11 + a32 * b21 + a33 * b31)
          (a31 * b12 + a32 * b22 + a33 * b32)
          (a31 * b13 + a32 * b23 + a33 * b33)

{-
 - -- ============================================================
-- Punkt transformieren
-- ============================================================

transformPoint :: Mat3 -> Point -> Point
transformPoint m (Point x y) =
  Point
    (m11 m * x + m12 m * y + m13 m)
    (m21 m * x + m22 m * y + m23 m)

-- ============================================================
-- Shape transformieren
-- ============================================================

transformShape :: Transform -> Shape -> Shape
transformShape tf (SPath cmds) =
  let m = toMat3 tf
      go (M p) = M (transformPoint m p)
      go (L p) = L (transformPoint m p)
   in SPath (map go cmds)

-- ============================================================
-- Orientierung → Richtungsvektor
-- ============================================================

orientationVector :: Double -> Point
orientationVector a = Point (cos a) (sin a)

translate :: Point -> Transform
translate (Point dx dy) = Translate dx dy
-}

rotate :: Double -> Transform
rotate a = Rotate a

scale :: Double -> Double -> Transform
scale sx sy = Scale sx sy

applyTransformToVec :: Transform -> Vec -> Vec
applyTransformToVec t = applyMat3 (toMat3 t)
