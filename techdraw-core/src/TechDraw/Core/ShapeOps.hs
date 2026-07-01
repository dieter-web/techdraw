module TechDraw.Core.ShapeOps
  ( applyTransform,
    normalizeShape,
  )
where

import TechDraw.Core.Transform
import TechDraw.Core.Types

-- import TechDraw.Core.Vec

applyTransform :: Transform -> Shape -> Shape
applyTransform t (SCircle c r) =
  SCircle (applyTransformToVec t c) r
applyTransform t (SLine a b) =
  SLine
    (applyTransformToVec t a)
    (applyTransformToVec t b)
applyTransform t (SPath vs) =
  SPath (map (applyTransformToVec t) vs)
applyTransform t (SGroup xs) =
  SGroup (map (applyTransform t) xs)
applyTransform t (STransformed sh ts) =
  STransformed sh (t : ts)

normalizeShape :: Shape -> Shape
normalizeShape (STransformed sh ts) =
  foldl (flip applyTransform) sh ts
normalizeShape sh = sh
