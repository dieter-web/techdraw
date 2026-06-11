module TechDraw.Electrical.Net
  ( NetId(..)
  , Net(..)
  , emptyNet
  , addPort
  , connect
  , mergeNets
  ) where

-- import TechDraw.Core.Types 
import TechDraw.Electrical.Ports(Port(..), PortId)

-- | Eindeutige ID für ein elektrisches Netz.
newtype NetId = NetId Int
  deriving (Show, Eq, Ord)

-- | Ein Netz besteht aus:
-- - einer ID
-- - einer Menge von Ports
-- - einer Menge von Verbindungen (PortId <-> PortId)
data Net = Net
  { netId :: NetId
  , netPorts :: [Port]
  , netLinks :: [(PortId, PortId)]
  } deriving (Show, Eq)

-- | Ein leeres Netz mit einer Id.
emptyNet :: NetId -> Net
emptyNet nid = Net nid [] []

-- | Fügt einen Port zu einem Netz hinzu
addPort :: Port -> Net -> Net 
addPort p net = net { netPorts = p : netPorts net}

-- | Verbindet zwei Ports innerhalb eines Netzes.
connect :: PortId -> PortId -> Net -> Net 
connect a b net = net { netLinks = (a,b) : netLinks net}

-- | Vereint zwei Netze zu einem.
-- (Ports und Links werden zusammengeführt)
mergeNets :: Net -> Net -> Net 
mergeNets n1 n2 =
  Net (netId n1)
      (netPorts n1 ++ netPorts n2)
      (netLinks n1 ++ netLinks n2)
