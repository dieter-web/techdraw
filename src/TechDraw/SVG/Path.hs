module TechDraw.SVG.Path
  ( PathCommand(..)
  )
  where

  data PathCommand
    = MoveTo Double Double                 -- M
    | MoveToRel Double Double              -- m

    | LineTo Double Double                 -- L
    | LineToRel Double Double              -- l

    | HLineTo Double                       -- H
    | HLineToRel Double                    -- h

    | VLineTo Double                       -- V
    | VLineToRel Double                    -- v

    | CubicTo Double Double Double Double Double Double      -- C
    | CubicToRel Double Double Double Double Double Double   -- c

    | SmoothCubicTo Double Double Double Double              -- S
    | SmoothCubicToRel Double Double Double Double           -- s

    | QuadTo Double Double Double Double                     -- Q
    | QuadToRel Double Double Double Double                  -- q

    | SmoothQuadTo Double Double                             -- T
    | SmoothQuadToRel Double Double                          -- t

    | ArcTo Double Double Double Bool Bool Double Double     -- A
    | ArcToRel Double Double Double Bool Bool Double Double  -- a

    | ClosePath                                              -- Z
    | ClosePathRel                                           -- z
    deriving (Show, Eq)
