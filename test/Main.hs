{-# OPTIONS_GHC -Wno-missing-signatures #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

module Main (main) where

import qualified DocImgs
import qualified VizTest

main :: IO ()
main = do
  DocImgs.main
  VizTest.main