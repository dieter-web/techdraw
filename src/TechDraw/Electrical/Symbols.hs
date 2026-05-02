module TechDraw.Electrical.Symbols
  ( renderSymbolRaw
  , renderSymbol
  , portsOf
  ) where

import TechDraw.SVG
import TechDraw.SVG.Types (Pos)
import TechDraw.Electrical.Types (SymbolType(..), Port(..))
import TechDraw.SVG.Center (centerSVG)

-- Einzelimporte aller Symbol-Module
import TechDraw.Electrical.Symbols.Resistor
import TechDraw.Electrical.Symbols.Potentiometer
import TechDraw.Electrical.Symbols.Trimmer
import TechDraw.Electrical.Symbols.ThermistorPTC
import TechDraw.Electrical.Symbols.ThermistorNTC

import TechDraw.Electrical.Symbols.Capacitor
import TechDraw.Electrical.Symbols.CapacitorPolarized
import TechDraw.Electrical.Symbols.CapacitorVariable
import TechDraw.Electrical.Symbols.CapacitorTrimmer

import TechDraw.Electrical.Symbols.Inductor
import TechDraw.Electrical.Symbols.Transformer

import TechDraw.Electrical.Symbols.SwitchOpen
import TechDraw.Electrical.Symbols.SwitchClosed
import TechDraw.Electrical.Symbols.SwitchSPDT
import TechDraw.Electrical.Symbols.SwitchDPDT
import TechDraw.Electrical.Symbols.SwitchToggle
import TechDraw.Electrical.Symbols.Switch2P
import TechDraw.Electrical.Symbols.PushButtonNO
import TechDraw.Electrical.Symbols.PushButtonNC

import TechDraw.Electrical.Symbols.Fuse
import TechDraw.Electrical.Symbols.FuseHolder
import TechDraw.Electrical.Symbols.FuseThermal
import TechDraw.Electrical.Symbols.CircuitBreaker

import TechDraw.Electrical.Symbols.Ground
import TechDraw.Electrical.Symbols.EarthProtective

import TechDraw.Electrical.Symbols.Motor
import TechDraw.Electrical.Symbols.Lamp

import TechDraw.Electrical.Symbols.Diode
import TechDraw.Electrical.Symbols.LED
import TechDraw.Electrical.Symbols.Zener

import TechDraw.Electrical.Symbols.TransistorNPN
import TechDraw.Electrical.Symbols.TransistorPNP
import TechDraw.Electrical.Symbols.OpAmp

import TechDraw.Electrical.Symbols.Battery
import TechDraw.Electrical.Symbols.DCSource
import TechDraw.Electrical.Symbols.ACSource

import TechDraw.Electrical.Symbols.Connector
import TechDraw.Electrical.Symbols.Terminal


-- | Dispatcher: wählt die passende Renderfunktion
-- renderSymbol :: SymbolType -> Pos -> SVG
renderSymbolRaw :: SymbolType -> Pos -> SVG
renderSymbolRaw sym pos =
  case sym of
    Resistor            -> renderResistor pos
    Potentiometer       -> renderPotentiometer pos
    Trimmer             -> renderTrimmer pos
    ThermistorPTC       -> renderThermistorPTC pos
    ThermistorNTC       -> renderThermistorNTC pos

    Capacitor           -> renderCapacitor pos
    CapacitorPolarized  -> renderCapacitorPolarized pos
    CapacitorVariable   -> renderCapacitorVariable pos
    CapacitorTrimmer    -> renderCapacitorTrimmer pos

    Inductor            -> renderInductor pos
    Transformer         -> renderTransformer pos

    SwitchOpen          -> renderSwitchOpen pos
    SwitchClosed        -> renderSwitchClosed pos
    SwitchSPDT          -> renderSwitchSPDT pos
    SwitchDPDT          -> renderSwitchDPDT pos
    SwitchToggle        -> renderSwitchToggle pos
    Switch2P            -> renderSwitch2P pos
    PushButtonNO        -> renderPushButtonNO pos
    PushButtonNC        -> renderPushButtonNC pos

    Fuse                -> renderFuse pos
    FuseHolder          -> renderFuseHolder pos
    FuseThermal         -> renderFuseThermal pos
    CircuitBreaker     -> renderCircuitBreaker pos

    Ground              -> renderGround pos
    EarthProtective     -> renderEarthProtective pos

    Motor               -> renderMotor pos
    Lamp                -> renderLamp pos

    Diode               -> renderDiode pos
    LED                 -> renderLED pos
    Zener               -> renderZener pos

    TransistorNPN       -> renderTransistorNPN pos
    TransistorPNP       -> renderTransistorPNP pos
    OpAmp               -> renderOpAmp pos

    Battery             -> renderBattery pos
    DCSource            -> renderDCSource pos
    ACSource            -> renderACSource pos

    Connector           -> renderConnector pos
    Terminal            -> renderTerminal pos

-- Zentrierung
renderSymbol :: SymbolType -> Pos -> SVG
renderSymbol t pos =
  centerSVG (renderSymbolRaw t pos)

-- Ports pro Symboltyp definieren
portsOf :: SymbolType -> [Port]
portsOf Resistor =
  [ Port "A" (-40,0) 180
  , Port "B" (40,0) 0
  ]
portsOf Capacitor =
  [ Port "A" (-30, 0) 180
  , Port "B" ( 30, 0)   0
  ]
portsOf Inductor =
  [ Port "A" (-40, 0) 180
  , Port "B" ( 40, 0)   0
  ]


