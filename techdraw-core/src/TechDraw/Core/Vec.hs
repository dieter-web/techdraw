module TechDraw.Core.Vec
  ( Vec (..),
    (+^),
    (-^),
    vscale,
    vdot,
    vnorm,
    vnormalize,
    vortho,
  )
where

-- import TechDraw.Core.Types (Point (..))

-- | Reiner mathematischer Vektor
data Vec
  = Vec Double Double
  deriving (Eq, Show)

(+^) :: Vec -> Vec -> Vec
(Vec ax ay) +^ (Vec bx by) = Vec (ax + bx) (ay + by)

(-^) :: Vec -> Vec -> Vec
(Vec ax ay) -^ (Vec bx by) = Vec (ax - bx) (ay - by)

vscale :: Double -> Vec -> Vec
vscale s (Vec x y) = Vec (s * x) (s * y)

vdot :: Vec -> Vec -> Double
vdot (Vec ax ay) (Vec bx by) = ax * bx + ay * by

vnorm :: Vec -> Double
vnorm (Vec x y) = sqrt (x * x + y * y)

vnormalize :: Vec -> Vec
vnormalize v@(Vec x y) =
  let n = vnorm v
   in Vec (x / n) (y / n)

-- | 90° Drehung
vortho :: Vec -> Vec
vortho (Vec x y) = Vec (-y) x

-- pointToVec :: Point -> Vec
-- pointToVec (Point x y) = Vec x y

-- vecToPoint :: Vec -> Point
-- vecToPoint (Vec x y) = Point x y
