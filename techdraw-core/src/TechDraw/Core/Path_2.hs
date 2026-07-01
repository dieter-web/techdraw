module TechDraw.Core.Path
  ( -- Punkt
    p,
    -- MoveTo
    m,
    M_,
    -- LineTo
    l,
    L_,
    -- Horizontal / Vertical
    h_,
    H_,
    v_,
    V_,
    -- Cubic Bézier
    c_,
    C_,
    s_,
    S_,
    -- Quadratic Bézier
    q_,
    Q_,
    t_,
    T_,
    -- Arc
    a_,
    A_,
    -- Close
    z_,
    Z_,
    -- Path builder
    path,
  )
where

import TechDraw.Core.Types

p :: Double -> Double -> Point
p = Point

m :: Double -> Double -> PathCmd
m x y = m (p x y)

M_ :: Double -> Double -> PathCmd 
M_ x y = M (Point x y) 

