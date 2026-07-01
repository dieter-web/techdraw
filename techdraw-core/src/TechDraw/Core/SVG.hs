{-# LANGUAGE OverloadedStrings #-}

module TechDraw.Core.SVG
  ( toSvgDoc,
    svgDocumentToText,
    writeSvgFile,
  )
where

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import TechDraw.Core.Style
  ( Fill (..),
    Stroke (..),
  )
import TechDraw.Core.Types
  ( PathCmd (..),
    Point (..),
    Shape (..),
    SvgDocument (..),
  )

-- \| Aus einer Liste von Shapes ein SvgDocument bauen.
toSvgDoc :: [(Shape, Stroke, Maybe Fill)] -> SvgDocument
toSvgDoc shapes =
  SvgDocument
    { svgWidth = 800,
      svgHeight = 600,
      svgContent = shapes
    }

-- | SvgDocument nach Text serialisieren
svgDocumentToText :: SvgDocument -> Text
svgDocumentToText doc =
  let header =
        T.concat
          [ "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n",
            "<svg xmlns=\"http://www.w3.org/2000/svg\" ",
            "width=\"",
            tShow (svgWidth doc),
            "\" ",
            "height=\"",
            tShow (svgHeight doc),
            "\" ",
            "viewBox=\"0 0",
            tShow (svgWidth doc),
            " ",
            tShow (svgHeight doc),
            "\">\n"
          ]
      body = T.concat (map renderShape (svgContent doc))
      footer = "</svg>\n"
   in header <> body <> footer

-- | SVG in Datei schreiben
writeSvgFile :: FilePath -> SvgDocument -> IO ()
writeSvgFile fp doc =
  T.writeFile fp (svgDocumentToText doc)

-- interne Helfer
renderShape :: (Shape, Stroke, Maybe Fill) -> Text
renderShape (SPath cmds, stroke, mFill) =
  let dAttr = renderPath cmds
      strokeAttr = renderStroke stroke
      fillAttr = maybe "fill=\"none\"" renderFill mFill
   in T.concat
        [ "<path d=\"",
          dAttr,
          "\" ",
          strokeAttr,
          " ",
          fillAttr,
          "/>\n"
        ]

renderPath :: [PathCmd] -> Text
renderPath = T.unwords . map renderCmd

renderCmd :: PathCmd -> Text
renderCmd (M (Point x y)) = T.concat ["M ", tShow x, " ", tShow y]
renderCmd (L (Point x y)) = T.concat ["L ", tShow x, " ", tShow y]

renderStroke :: Stroke -> Text
renderStroke (Stroke color width) =
  T.concat
    [ "stroke=\"",
      color,
      "\" ",
      "stroke-width=\"",
      tShow width,
      "\" ",
      "stroke-linecap=\"round\" stroke-linejoin=\"round\""
    ]

renderFill :: Fill -> Text
renderFill (Fill color) =
  T.concat ["fill=\"", color, "\""]

tShow :: (Show a) => a -> Text
tShow = T.pack . show
