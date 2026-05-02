-- file: src/TechDraw/SVG/Path/Tokenizer.hs
module TechDraw.SVG.Path.Tokenizer
  ( tokenize
  ) where

import Data.Char (isDigit, isSpace)
import TechDraw.SVG.Path.Types

tokenize :: String -> [Token]
tokenize [] = []
tokenize (c:cs)
  | isSpace c = tokenize cs
  | c == ','  = Comma : tokenize cs
  | isDigit c || c == '-' =
      let (num, rest) = span (\x -> isDigit x || x == '.' || x == '-') (c:cs)
      in Number (read num) : tokenize rest
  | otherwise = Letter c : tokenize cs





--import Data.Char (isDigit, isSpace)
-- Tokenizer (SVG-konform)
--tokenize :: String -> [Token]
--tokenize [] = []
--tokenize (c:cs)
--  | c `elem` "MmLlHhVvCcSsQqTtAaZz" = TCmd c : tokenize cs
--  | isSpace c || c == ',' = tokenize cs
--  | c == '-' || isDigit c =
--      let (num, rest) = span (\x -> isDigit x || x `elem` ".eE+-") (c:cs)
--      in TNum (read num) : tokenize rest
--  | otherwise = tokenize cs
