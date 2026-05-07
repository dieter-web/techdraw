{-# LANGUAGE RecordWildCards #-}

module TechDraw.Electrical.Wire (
    Wire (..),
    renderWire,
    renderWireOrtho,
) where

import TechDraw.Electrical.Types (
    Port (..),
 )
import TechDraw.SVG (
    Color (..),
    LineCap (..),
    LineJoin (..),
    Point,
    SVG (..),
    Stroke (..),
    StrokeStyle (..),
 )

import TechDraw.SVG.Render (
    renderSVG,
 )

import TechDraw.SVG.Style (
    toStroke,
 )

-- | Verbindung zwischen zwei Ports.
data Wire = Wire
    { wireFrom :: Port
    , wireTo :: Port
    }
    deriving (Eq, Show)

-- | Standard-Stroke für Wires (lokal, unabhängig von Symbol-Strokes).
wireStroke :: StrokeStyle
wireStroke =
    StrokeStyle
        { styleColor = Named "black"
        , styleWidth = 1.2
        , styleLineCap = CapRound
        , styleLineJoin = JoinRound
        }

-- | Einfache direkte Verbindung (Gerade) zwischen zwei Ports.
renderWire :: Wire -> SVG
renderWire (Wire (Port _ p1 _) (Port _ p2 _)) =
    Line p1 p2 (Just (toStroke wireStroke))

{- | Orthogonales Routing (L-Form, 2 Segmente, 90°-Knick).
  Aktuell: zuerst horizontal, dann vertikal.
-}
renderWireOrtho :: Wire -> SVG
renderWireOrtho (Wire (Port _ (x1, y1) _) (Port _ (x2, y2) _)) =
    let mid = (x2, y1)
     in Group
            [ LineStyled (x1, y1) mid wireStroke
            , LineStyled mid (x2, y2) wireStroke
            ]
