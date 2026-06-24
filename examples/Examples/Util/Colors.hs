module Examples.Util.Colors where

import NeonCAD

blue = vec (0.298, 0.471, 0.659) :: V3 Double

orange = vec (0.961, 0.522, 0.094) :: V3 Double

green = vec (0.329, 0.635, 0.294) :: V3 Double

red = vec (0.894, 0.341, 0.337) :: V3 Double

purple = vec (0.698, 0.475, 0.635) :: V3 Double

teal = vec (0.447, 0.718, 0.698) :: V3 Double

gray = vec (0.498, 0.498, 0.498) :: V3 Double

brown = vec (0.616, 0.459, 0.353) :: V3 Double

olive = vec (0.580, 0.584, 0.192) :: V3 Double

pink = vec (0.906, 0.541, 0.765) :: V3 Double

cyan = vec (0.337, 0.706, 0.914) :: V3 Double

gold = vec (0.855, 0.647, 0.125) :: V3 Double

lime = vec (0.565, 0.753, 0.263) :: V3 Double

lavender = vec (0.729, 0.624, 0.859) :: V3 Double

coral = vec (0.929, 0.490, 0.192) :: V3 Double

white = vec (1, 1, 1) :: V3 Double

colors :: [V3 Double]
colors =
  [ blue,
    orange,
    green,
    red,
    purple,
    teal,
    gold,
    pink,
    cyan,
    brown,
    lime,
    coral,
    lavender,
    olive,
    gray
  ]