module Main (main) where

import NeonCAD
import Data.Functor.Identity (Identity(runIdentity))


main :: IO ()
main = do
    writeFile "renderings/01.scad" (render2D $ runNeonM (fn 30) $ circleR 30 )