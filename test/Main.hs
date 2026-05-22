module Main (main) where

import NeonCAD

spreadX :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadX modelsM =
  moveX 100 $
    union $
      zipWith
        ( \i x ->
            moveX (fromIntegral i * 200) x
        )
        [0 ..]
        modelsM

spreadY :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadY modelsM =
  moveY 100 $
    union $
      zipWith
        ( \i x ->
            union
              [ moveY (fromIntegral i * 200) $
                  union
                    [ x
                    ]
              ]
        )
        [0 ..]
        modelsM

drawGrid :: (MonadNeon m) => m Model2D
drawGrid =
  comment "Grid" $
    moveXY (100, 100) $
      union $
        map
          ( \x ->
              comment ("X: " ++ show x) $
                union $
                  map (\y -> comment ("Y: " ++ show y) $ drawGridItem x y) [0 .. 20]
          )
          [0 .. 10]

drawGridItem :: (MonadNeon m) => Int -> Int -> m Model2D
drawGridItem x_ y_ =
  moveXY (x * 200, y * 200) $
    union
      [ moveZ (-5) $ colorRGB (1, 1, 1) $ rectCenter (190, 190)
      , moveZ (-4) $ colorRGBA (1, 0, 0) 0.5 $ union [rectCenter (1, 190), rectCenter (190, 1)]
      ]
 where
  x = fromIntegral x_
  y = fromIntegral y_

drawSamples :: (MonadNeon m) => m Model2D
drawSamples =
  spreadY
    [ comment "Circle" $
        spreadX
          [ comment "circleR" $ circleR 50
          , comment "circleD" $ circleD 50
          ]
    , comment "Ellipse" $
        spreadX
          [ ellipseR (50, 30)
          , ellipseD (50, 30)
          ]
    , -- Rect
      spreadX
        [ rect (50, 30)
        , rectCenter (50, 30)
        ]
    , -- Square
      spreadX
        [ square 50
        , squareCenter 50
        ]
    , -- Polygon
      spreadX
        [ polygon [(17, 17), (38, 33), (58, 15), (90, 35), (81, 75), (59, 59), (43, 68), (45, 80), (18, 86), (8, 46), (17, 17)]
        ]
    , -- Scale
      spreadX
        [ rect (20, 30)
        , scaleX 2 $ rect (20, 30)
        , scaleY 2 $ scaleX 2 $ rect (20, 30)
        , scaleXY (2, 2) $ scaleX 2 $ rect (20, 30)
        ]
    , -- Resize
      spreadX
        [ rect (20, 30)
        , resizeX 40 $ rect (20, 30)
        , resizeY 60 $ resizeX 20 $ rect (20, 30)
        , resizeXY (40, 60) $ resizeX 20 $ rect (20, 30)
        ]
    , -- Rotate
      spreadX
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
    , -- Mirror
      spreadX
        [ rect (50, 30)
        , mirrorX $ rect (50, 30)
        ]
    , -- Color
      spreadX
        [ rect (50, 30)
        , colorRGB (1, 0, 0) $ rect (50, 30)
        , colorRGBA (1, 0, 0) 0.5 $ rect (50, 30)
        , color (1, 0, 0) (Just 0.5) $ rect (50, 30)
        ]
    , -- Text
      spreadX
        [ text "Hello, World!" defaultTextOpts
        -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationMono })
        -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSans })
        -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSerif })
        -- , text "Hello, World!" (defaultTextOpts { textFont = FNCustom "Arial" })
        ]
    , -- TODO: offset examples
      spreadX
        [ hull
            [ moveXY (50, 50) $ squareCenter 50
            , circleD 50
            ]
        ]
    ]

draw :: (MonadNeon m) => m Model2D
draw = union [drawSamples, drawGrid]

main :: IO ()
main = do
  writeFile
    "renderings/01.scad"
    ( render2D $
        runNeonM defaultFacets draw
    )
