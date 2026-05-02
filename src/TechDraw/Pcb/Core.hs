module TechDraw.Pcb.Core
  ( bbox
  , move
  , center
  --, group
  --, point
  ) where

import TechDraw.Pcb.Types
import TechDraw.SVG.Types

-- | Compute a bounding box for a single elements
bbox :: TechElement -> (Point, Point)
bbox (EModuleBox (Point x y) w h _) =
  (Point x y, Point (x + w) (y + h))

bbox (EConnector p1 p2 _) =
  (Point (min (px p1) (px p2)) (min (py p1) (py p2)),
   Point (max (px p1) (px p2)) (max (py p1) (py p2)))

bbox (EMountHole (Point x y) d) =
  let r = d / 2
  in (Point (x - r) (y - r), Point (x + r) (y + r))

bbox (EDimension p1 p2 _) =
  (Point (min (px p1) (px p2)) (min (py p1) (py p2)),
   Point (max (px p1) (px p2)) (max (py p1) (py p2)))

bbox (ELabel (Point x y) _) =
  (Point x y, Point (x + 20) (y + 10))  -- placeholder

bbox (EGroup elems) =
  foldl1 merge (map bbox elems)
  where
    merge (Point x1 y1, Point x2 y2)
          (Point x3 y3, Point x4 y4) =
      (Point (min x1 x3) (min y1 y3),
       Point (max x2 x4) (max y2 y4))

-- | Move an element by dx, dy
move :: Double -> Double -> TechElement -> TechElement
move dx dy (EModuleBox (Point x y) w h lbl) =
  EModuleBox (Point (x+dx) (y+dy)) w h lbl

move dx dy (EConnector p1 p2 name) =
  EConnector (shift p1) (shift p2) name
  where shift (Point x y) = Point (x+dx) (y+dy)

move dx dy (EMountHole (Point x y) d) =
  EMountHole (Point (x+dx) (y+dy)) d

move dx dy (EDimension p1 p2 txt) =
  EDimension (shift p1) (shift p2) txt
  where shift (Point x y) = Point (x+dx) (y+dy)

move dx dy (ELabel (Point x y) txt) =
  ELabel (Point (x+dx) (y+dy)) txt

move dx dy (EGroup elems) =
  EGroup (map (move dx dy) elems)

-- | Center an element around the origin
center :: TechElement -> TechElement
center el =
  let (Point x1 y1, Point x2 y2) = bbox el
      cx = (x1 + x2) / 2
      cy = (y1 + y2) / 2
  in move (-cx) (-cy) el

-- | Group Elements

group :: [TechElement] -> TechElement
group = EGroup

point :: Double -> Double -> Point
point = Point

