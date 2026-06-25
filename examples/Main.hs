module Main where

import qualified Examples.BoxWithHoles
import qualified Examples.BuckConverterCase
import qualified Examples.BuiltinShapes2D
import qualified Examples.Ring
import qualified Examples.SplitSolid

main :: IO ()
main = do
    Examples.BoxWithHoles.main
    Examples.BuckConverterCase.main
    Examples.SplitSolid.main
    Examples.BuiltinShapes2D.main
    Examples.Ring.main
