module Main where

import qualified Examples.BoxWithHoles
import qualified Examples.BuckConverterCase
import qualified Examples.SplitSolid

main :: IO ()
main = do
    Examples.BoxWithHoles.main
    Examples.BuckConverterCase.main
    Examples.SplitSolid.main
