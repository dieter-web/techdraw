module TechDraw.Pcb.Utils where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.Pcb.Types hiding (Point)
import TechDraw.Pcb.Types
import TechDraw.Pcb.DSL

stroke :: Maybe Stroke
stroke = Just (StrokeColor "black" 0.5)

rect :: Pos -> Length -> Length -> SVG
rect p w h = Rect p (w,h) stroke FillNone

line :: Pos -> Pos -> SVG
line p1 p2 = Line p1 p2 stroke

circle :: Pos -> Length -> SVG
circle c r = Circle c r stroke FillNone

polyline :: [Pos] -> SVG
polyline ps = Polyline ps stroke

text :: Pos -> String -> SVG
text p s = Text p AnchorStart s

group :: [SVG] -> SVG
group = Group


