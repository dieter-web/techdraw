kicadGraphicToSVG :: KiCadGraphic -> SVG
kicadGraphicToSVG g = case g of

  -- 1. Polyline
  GPolyline pts ->
    Polyline (map kpt pts) defaultStroke

  -- 2. Circle
  GCircle center r ->
    Circle (kpt center) r defaultStroke FillNone

  -- 3. Rectangle
  GRect p1 p2 ->
    let (x1,y1) = kpt p1
        (x2,y2) = kpt p2
    in Rect (x1,y1) (x2-x1, y2-y1) defaultStroke FillNone

  -- 4. Arc (Start–Mid–End → Path)
  GArc s m e ->
    Path
      [ MoveTo (kpt s)
      , QuadTo (kpX m) (kpY m) (kpX e) (kpY e)
      ]
      defaultStroke
      FillNone

  -- 5. Text
  GText pos _rot txt ->
    Text (kpt pos) AnchorMiddle txt

  -- 6. Pin (Linie + Name + Nummer)
  GPin pos angle len name num ->
    Group
      [ Line pStart pEnd defaultStroke
      , Text (shift pEnd (-1.0)) AnchorStart name
      , Text (shift pEnd (-2.0)) AnchorStart num
      ]
    where
      pStart = kpt pos
      rad    = angle * pi / 180
      dx     = len * cos rad
      dy     = len * sin rad
      pEnd   = let (x,y) = pStart in (x+dx, y+dy)

      shift (x,y) d = (x + d * cos rad, y + d * sin rad)
