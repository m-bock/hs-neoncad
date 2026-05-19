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
                    , spreadX
                        [ polygon [(17, 17), (38, 33), (58, 15), (90, 35), (81, 75), (59, 59), (43, 68), (45, 80), (18, 86), (8, 46), (17, 17)]
                        ]
                    , spreadX
                        [ rect (50, 30)
                        , rotateZ 45 $ rect (50, 30)
                        , rotateZ 90 $ rect (50, 30)
                        , rotateZ 135 $ rect (50, 30)
                        , rotateZ 180 $ rect (50, 30)
                        , rotateZ 225 $ rect (50, 30)
                        , rotateZ 270 $ rect (50, 30)
                        , rotateZ 315 $ rect (50, 30)
                        , rotateZ 360 $ rect (50, 30)
                        ]
                    , spreadX
                        [ rect (50, 30)
                        , mirrorX $ rect (50, 30)
                        ]
                    , spreadX
                        [ rect (50, 30)
                        , colorRGB (1, 0, 0) $ rect (50, 30)
                        , colorRGBA (1, 0, 0) 0.5 $ rect (50, 30)
                        , colorA 0.5 $ rect (50, 30)
                        ]
                    ]
        )
