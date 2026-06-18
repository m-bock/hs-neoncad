module Main where

import qualified Examples.BoxWithHoles
import qualified Examples.BuckConverterCase

main :: IO ()
main = do
    Examples.BoxWithHoles.main
    Examples.BuckConverterCase.main
