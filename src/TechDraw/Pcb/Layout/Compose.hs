module TechDraw.Pcb.Layout.Compose
  ( beside
  , above
  , compose
  ) where

import TechDraw.Pcb.Types
import TechDraw.Pcb.Core (bbox, move)

-- | Place b to the right of a (with spacing)
beside :: Double -> TechElement -> TechElement -> TechElement
beside spacing a b =
  let (_, Point ax2 _) = bbox a
      (Point bx _, _)  = bbox b
      dx = ax2 - bx + spacing
  in EGroup [a, move dx 0 b]

-- | Place b above a (with spacing)
above :: Double -> TechElement -> TechElement -> TechElement
above spacing a b =
  let (_, Point _ ay2) = bbox a
      (Point _ by, _)  = bbox b
      dy = ay2 - by + spacing
  in EGroup [a, move 0 dy b]



-- | Placeholder: combine two elements into a group
compose :: TechElement -> TechElement -> TechElement
compose a b = EGroup [a, b]

