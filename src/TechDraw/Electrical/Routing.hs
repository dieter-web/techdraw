-- file: src/TechDraw/Electrical/Routing.hs
module TechDraw.Electrical.Routing (
    manhattanWire,
) where

import TechDraw.Electrical.Types
import TechDraw.SVG.Types

-- einfacher 2-Segment-Manhattan-Wire: horizontal dann vertikal
manhattanWire :: Pos -> Pos -> Wire
manhattanWire (x1, y1) (x2, y2) =
    let mid = (x2, y1)
     in Wire [(x1, y1), mid, (x2, y2)]
