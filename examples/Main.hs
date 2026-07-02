module Main where

import Examples.BoxWithHoles qualified
import Examples.BuckConverterCase qualified
import Examples.BuiltinShapes2D qualified
import Examples.PencilHolder qualified
import Examples.Random qualified
import Examples.Ring qualified
import Examples.SplitSolid qualified

main :: IO ()
main = do
  Examples.BoxWithHoles.main
  Examples.BuckConverterCase.main
  Examples.SplitSolid.main
  Examples.BuiltinShapes2D.main
  Examples.Ring.main
  Examples.Random.main
  Examples.PencilHolder.main
