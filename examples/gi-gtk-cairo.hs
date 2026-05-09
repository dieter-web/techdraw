{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.GI.Base
import qualified GI.Cairo as Cairo
import qualified GI.Cairo.Render as R
import qualified GI.Gdk as Gdk
import qualified GI.Gtk as Gtk

main :: IO ()
main = do
    Gtk.init Nothing

    window <-
        new
            Gtk.Window
            [ #title := "GTK3 + GI.Cairo"
            , #defaultWidth := 400
            , #defaultHeight := 300
            ]

    area <- new Gtk.DrawingArea []
    on area #draw draw

    #add window area
    on window #destroy Gtk.mainQuit

    #showAll window
    Gtk.main

draw :: Gtk.DrawingArea -> Cairo.Context -> IO Bool
draw _ cr = do
    R.setSourceRGB cr 1 1 1
    R.paint cr

    R.setSourceRGB cr 0 0 0
    R.setLineWidth cr 3
    R.moveTo cr 50 50
    R.lineTo cr 350 250
    R.stroke cr

    R.setSourceRGB cr 1 0 0
    R.arc cr 200 150 60 0 (2 * pi)
    R.fill cr

    pure True
