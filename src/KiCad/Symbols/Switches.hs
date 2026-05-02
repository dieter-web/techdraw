module TechDraw.Electrical.Symbols.Switches
  ( renderSwitchOpen
  , renderSwitchClosed
  , renderSwitchSPDT
  , renderSwitchDPDT
  , renderPushButtonNO
  , renderPushButtonNC
  , renderToggleSwitch
  , renderSwitch2P
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types
import TechDraw.Electrical.Types

-- Einpoliger Schalter (offen)
renderSwitchOpen :: Point -> SVG
renderSwitchOpen (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+10, y) (x+25, y-8) (Just (StrokeColor "black" 1))
    , Line (x+25, y-8) (x+40, y-8) (Just (StrokeColor "black" 1))
    ]

-- Einpoliger Schalter (geschlossen)
renderSwitchClosed :: Point -> SVG
renderSwitchClosed (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+10, y) (x+25, y) (Just (StrokeColor "black" 1))
    , Line (x+25, y) (x+40, y) (Just (StrokeColor "black" 1))
    ]

-- Wechselschalter (SPDT)
renderSwitchSPDT :: Point -> SVG
renderSwitchSPDT (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+10, y) (x+25, y-8) (Just (StrokeColor "black" 1))
    , Circle (x+40, y-8) 2 (Just (StrokeColor "black" 1)) FillNone
    , Circle (x+40, y+8) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+40, y-8) (x+55, y-8) (Just (StrokeColor "black" 1))
    , Line (x+40, y+8) (x+55, y+8) (Just (StrokeColor "black" 1))
    ]

-- Umschalter (DPDT)
renderSwitchDPDT :: Point -> SVG
renderSwitchDPDT (x,y) =
  Group
    [ renderSwitchSPDT (x, y-12)
    , renderSwitchSPDT (x, y+12)
    ]

-- Taster (NO)
renderPushButtonNO :: Point -> SVG
renderPushButtonNO (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+12, y-4) (x+25, y-4) (Just (StrokeColor "black" 1))
    , Line (x+25, y-4) (x+40, y-4) (Just (StrokeColor "black" 1))
    ]

-- Taster (NC)
renderPushButtonNC :: Point -> SVG
renderPushButtonNC (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+12, y+4) (x+25, y+4) (Just (StrokeColor "black" 1))
    , Line (x+25, y+4) (x+40, y+4) (Just (StrokeColor "black" 1))
    ]

-- Kippschalter
renderToggleSwitch :: Point -> SVG
renderToggleSwitch (x,y) =
  Group
    [ Line (x, y) (x+10, y) (Just (StrokeColor "black" 1))
    , Circle (x+10, y) 2 (Just (StrokeColor "black" 1)) FillNone
    , Line (x+10, y) (x+20, y-12) (Just (StrokeColor "black" 1))
    , Line (x+20, y-12) (x+40, y-12) (Just (StrokeColor "black" 1))
    ]

-- Zweipoliger Schalter
renderSwitch2P :: Point -> SVG
renderSwitch2P (x,y) =
  Group
    [ renderSwitchOpen (x, y-10)
    , renderSwitchOpen (x, y+10)
    ]
