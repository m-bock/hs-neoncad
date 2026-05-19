module Main (main) where

import NeonCAD

main :: IO ()
main = do
    writeFile "renderings/01.scad" (render2D $ runNeonM defaultFacets $ circleR 30)