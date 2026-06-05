{-# OPTIONS_GHC -Wno-missing-signatures #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

module Main (main) where

import qualified DocImgs
import Test.DocTest

-- import qualified VizTest

main :: IO ()
main = do
  DocImgs.main

  doctest
    [ "-isrc"
    , "src/NeonCAD.hs"
    ]

-- VizTest.main