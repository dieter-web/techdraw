module TechDraw.SVG.BoundingBox
  ( bbox  
  , pathToPoints
  ) where

import TechDraw.SVG.Types
import TechDraw.SVG.Matrix
import TechDraw.SVG

import TechDraw.SVG.Path

type BBox = (Pos, Pos)

--Hilfsfunktionen - Punkt transformieren 
applyMat :: Mat3 -> Pos -> Pos
applyMat ((a,c,e),(b,d,f),_) (x,y) =
  (a*x + c*y + e, b*x + d*y + f)

-- Bounding-Box für primitive SVG-Elemente
bbox :: SVG -> BBox

bbox (Line p1 p2 _) =
  (minPos p1 p2, maxPos p1 p2)

bbox (Circle (cx, cy) r _ _) =
  ((cx - r, cy - r), (cx + r, cy + r))

bbox (Rect (x,y) (w,h) _ _) =
  ((x, y), (x + w, y + h))

bbox (Polygon pts _ _) =
  (minimum pts, maximum pts)

bbox (Polyline pts _) =
  (minimum pts, maximum pts)

bbox (Path cmds _ _) =
  let pts = pathToPoints cmds
  in (minimum pts, maximum pts)

bbox (Text (x,y) _anchor _str) =
  -- einfache Nährung: Text als Punkt
  ((x,y),(x,y))

-- Bounding-Box für Gruppen
bbox(Group svgs) =
  foldl1 merge (map bbox svgs)
  where
    merge ((x1,y1),(x2,y2))((x1',y1'),(x2',y2')) =
      ( (min x1 x1', min y1 y1')
      , (max x2 x2', max y2 y2')
      )

-- Bounding-Box für Transform-Listen
bbox (Transform trs svg) =
  let mat = combineTransforms trs
      ((minX,minY),(maxX,maxY)) = bbox svg
      corners =
        [ (minX, minY)
        , (minX, maxY)
        , (maxX, minY)
        , (maxX, maxY)
        ]
      pts = map (applyMat mat) corners
  in (minimum pts, maximum pts)




-- Hilfsfunktionen
minPos (x1, y1) (x2, y2) = (min x1 x2, min y1 y2)
maxPos (x1, y1) (x2, y2) = (max x1 x2, max y1 y2)

pathToPoints :: [PathCommand] -> [Pos]
pathToPoints cmds = 
  [ (x,y)
  | MoveTo x y <- cmds ] ++
  [ (x,y)
  | LineTo x y <- cmds ]

