-- file: src/TechDraw/SVG/Path/Types.hs
module TechDraw.SVG.Path.Types
  ( PathCommand(..)
  , Token(..)
  ) where

-- Token-Typ für den Tokenizer
data Token
  = Number Double
  | Letter Char
  | Comma
  deriving (Show, Eq)

-- SVG Path Commands
data PathCommand
  = MoveTo Double Double
  | MoveToRel Double Double
  | LineTo Double Double
  | LineToRel Double Double
  | HLineTo Double
  | HLineToRel Double
  | VLineTo Double
  | VLineToRel Double
  | CubicTo Double Double Double Double Double Double
  | CubicToRel Double Double Double Double Double Double
  | SmoothCubicTo Double Double Double Double
  | SmoothCubicToRel Double Double Double Double
  | QuadTo Double Double Double Double
  | QuadToRel Double Double Double Double
  | SmoothQuadTo Double Double
  | SmoothQuadToRel Double Double
  | ArcTo Double Double Double Bool Bool Double Double
  | ArcToRel Double Double Double Bool Bool Double Double
  | ClosePath
  | ClosePathRel
  deriving (Show, Eq)
