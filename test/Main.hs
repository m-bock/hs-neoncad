module Main (main) where

import NeonCAD

main :: IO ()
main = do
    writeFile
        "renderings/01.scad"
        ( render2D $
            runNeonM defaultFacets $
                union2D
                    [ moveXY (100, 100) [circleR 30]
                    , circleR 40
                    ]
        )