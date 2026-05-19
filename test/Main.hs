module Main (main) where

import NeonCAD

spreadX :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadX modelsM = union2D $ zipWith (\i x -> moveX (fromIntegral i * 100) x) [0 ..] modelsM

spreadY :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadY modelsM = union2D $ zipWith (\i x -> moveY (fromIntegral i * 100) x) [0 ..] modelsM

main :: IO ()
main = do
    writeFile
        "renderings/01.scad"
        ( render2D $
            runNeonM defaultFacets $
                spreadY
                    [ spreadX
                        [ circleR 50
                        , circleD 50
                        ]
                    , spreadX
                        [ ellipseR (50, 30)
                        , ellipseD (50, 30)
                        ]
                    , spreadX
                        [ rect (50, 30)
                        , rectCenter (50, 30)
                        ]
                    , spreadX
                        [ square 50
                        , squareCenter 50
                        ]
                    ]
        )