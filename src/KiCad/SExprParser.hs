module KiCad.SExprParser
  ( KiCadLibrary(..)
  , parseKiCadLibrary
  , parseKiCadSymbol
  ) where

import Text.Megaparsec
import Text.Megaparsec.Char
import Data.Void
import Data.Maybe (catMaybes)

import KiCad.Symbol
  ( KiCadSymbol(..)
  , KiCadGraphic(..)
  , KiCadPoint(..)
  )

-- Top-Level: ganze Bibliothek
data KiCadLibrary = KiCadLibrary
  { libSymbols :: [KiCadSymbol]
  }
  deriving (Show, Eq)

type Parser = Parsec Void String


-- (kicad_symbol_lib ... (symbol ...) ...)
pLibrary :: Parser KiCadLibrary
pLibrary = do
  _ <- string "(kicad_symbol_lib"
  space
  many (pVersionOrGenerator <* space)
  syms <- many (pSymbol <* space)
  _ <- char ')'
  pure (KiCadLibrary syms)


pVersionOrGenerator :: Parser ()
pVersionOrGenerator =
      try pVersion
  <|> try pGenerator

pVersion :: Parser ()
pVersion = do
  _ <- string "(version"
  space1
  _ <- manyTill anySingle (char ')')
  pure ()

pGenerator :: Parser ()
pGenerator = do
  _ <- string "(generator"
  space1
  _ <- manyTill anySingle (char ')')
  pure ()

pSkip :: Parser()
pSkip = do
  _ <- char '('
  manyTill anySingle (char ')')
  pure ()

-- Ein rekursiver Skip-Parser
pSkipAny :: Parser ()
pSkipAny = do
  _ <- char '('
  skipMany (pSkipAny <|> skipNonParen)
  _ <- char ')'
  pure ()

skipNonParen :: Parser ()
skipNonParen = do
  _ <- noneOf ['(', ')']
  pure ()



-- SymbolItem
pSymbolItem :: Parser (Maybe KiCadGraphic)
pSymbolItem =
      try (Just <$> pPolyline)
  <|> try (Just <$> pCircle)
  <|> (pSkipAny *> pure Nothing)

-- (xy 10 20)
pPoint :: Parser KiCadPoint
pPoint = do
  _ <- string "(xy"
  space1
  x <- read <$> some (digitChar <|> char '.' <|> char '-')
  space1
  y <- read <$> some (digitChar <|> char '.' <|> char '-')
  _ <- char ')'
  pure (KiCadPoint x y)


-- (polyline (pts (xy ...) (xy ...)))
pPolyline :: Parser KiCadGraphic
pPolyline = do
  _ <- string "(polyline"
  space
  _ <- string "(pts"
  space
  pts <- many (pPoint <* space)
  _ <- char ')'
  _ <- char ')'
  pure (Polyline pts)


-- (circle (center (xy ...)) (radius 1.5))
pCircle :: Parser KiCadGraphic
pCircle = do
  _ <- string "(circle"
  space
  _ <- string "(center"
  space
  c <- pPoint
  _ <- char ')'
  space
  _ <- string "(radius"
  space
  r <- read <$> some (digitChar <|> char '.' <|> char '-')
  _ <- char ')'
  _ <- char ')'
  pure (Circle c r)

-- kombinierter Parser
pGraphicOrSkip :: Parser (Maybe KiCadGraphic)
pGraphicOrSkip =
      try (Just <$> pPolyline)
  <|> try (Just <$> pCircle)
  <|> (pSkipAny *> pure Nothing)


-- (symbol "Name" ...)
pSymbol :: Parser KiCadSymbol
pSymbol = do
  _ <- string "(symbol"
  space1
  _ <- char '"'
  name <- manyTill anySingle (char '"')
  space
  items <- many (pGraphicOrSkip <* space)
  _ <- char ')'
  pure (KiCadSymbol name (catMaybes items))

-- Parser für ganze Bibliothek
parseKiCadLibrary :: String -> Either String KiCadLibrary
parseKiCadLibrary input =
  case parse pLibrary "" input of
    Left err -> Left (errorBundlePretty err)
    Right lib -> Right lib


-- Parser für EIN Symbol (nur für Tests)
parseKiCadSymbol :: String -> Either String KiCadSymbol
parseKiCadSymbol input =
  case parse pSymbol "" input of
    Left err -> Left (errorBundlePretty err)
    Right s  -> Right s
