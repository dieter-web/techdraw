arc :: Point -> Length -> Length -> Double -> Bool -> Bool -> Point -> SVG
arc start rx ry rot large sweep end =
  Path
    [ moveTo start
    , arcTo rx ry rot large sweep end
    ]
    (Just defaultStroke)
    NoFill
