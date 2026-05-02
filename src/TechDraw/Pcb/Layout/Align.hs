module TechDraw.Pcb.Layout.Align
  ( alignLeft
  , alignRight
  , alignTop
  , alignBottom
  , alignCenterX
  , alignCenterY
  ) where

import TechDraw.Pcb.Types
import TechDraw.Pcb.Core (bbox, move)

-- | Align b to the left edge of a
alignLeft :: TechElement -> TechElement -> TechElement
alignLeft a b =
  let (Point ax _, _) = bbox a
      (Point bx _, _) = bbox b
  in move (ax - bx) 0 b

-- | Align b to the right edge of a
alignRight :: TechElement -> TechElement -> TechElement
alignRight a b =
  let (_, Point ax2 _) = bbox a
      (Point bx _, Point bx2 _) = bbox b
  in move (ax2 - bx2) 0 b

-- | Align b to the top edge of a
alignTop :: TechElement -> TechElement -> TechElement
alignTop a b =
  let (_, Point _ ay2) = bbox a
      (Point _ by, Point _ by2) = bbox b
  in move 0 (ay2 - by2) b

-- | Align b to the bottom edge of a
alignBottom :: TechElement -> TechElement -> TechElement
alignBottom a b =
  let (Point _ ay, _) = bbox a
      (Point _ by, _) = bbox b
  in move 0 (ay - by) b

-- | Center b horizontally relative to a
alignCenterX :: TechElement -> TechElement -> TechElement
alignCenterX a b =
  let (Point ax ay, Point ax2 ay2) = bbox a
      (Point bx by, Point bx2 by2) = bbox b
      acx = (ax + ax2) / 2
      bcx = (bx + bx2) / 2
  in move (acx - bcx) 0 b

-- | Center b vertically relative to a
alignCenterY :: TechElement -> TechElement -> TechElement
alignCenterY a b =
  let (Point ax ay, Point ax2 ay2) = bbox a
      (Point bx by, Point bx2 by2) = bbox b
      acy = (ay + ay2) / 2
      bcy = (by + by2) / 2
  in move 0 (acy - bcy) b

