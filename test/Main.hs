module Main (main) where

import NeonCAD

spreadX :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadX modelsM =
  moveX 100 $
    unions $
      zipWith
        ( \i x ->
            moveX (fromIntegral i * 200) x
        )
        [0 ..]
        modelsM

spreadY :: (MonadNeon m) => [m Model2D] -> m Model2D
spreadY modelsM =
  moveY 100 $
    unions $
      zipWith
        ( \i x ->
            moveY (fromIntegral i * 200) x
        )
        [0 ..]
        modelsM

drawGrid :: (MonadNeon m) => m Model2D
drawGrid =
  comment "Grid" $
    moveXY (100, 100) $
      unions $
        map
          ( \x ->
              comment ("X: " ++ show x) $
                unions $
                  map (\y -> comment ("Y: " ++ show y) $ drawGridItem x y) [0 .. 20]
          )
          [0 .. 10]

drawGridItem :: (MonadNeon m) => Int -> Int -> m Model2D
drawGridItem x_ y_ =
  moveXY (x * 200, y * 200) $
    unions
      [ moveZ (-5) $ colorRGB (1, 1, 1) $ rectCenter (190, 190)
      , moveZ (-4) $ colorRGBA (1, 0, 0) 0.5 $ unions [rectCenter (1, 190), rectCenter (190, 1)]
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
    , comment "Rect" $
        spreadX
          [ rect (50, 30)
          , rectCenter (50, 30)
          ]
    , comment "Square" $
        spreadX
          [ square 50
          , squareCenter 50
          ]
    , comment "Polygon" $
        spreadX
          [ polygon [(17, 17), (38, 33), (58, 15), (90, 35), (81, 75), (59, 59), (43, 68), (45, 80), (18, 86), (8, 46), (17, 17)]
          ]
    , comment "Scale" $
        spreadX
          [ rect (20, 30)
          , scaleX 2 $ rect (20, 30)
          , scaleY 2 $ scaleX 2 $ rect (20, 30)
          , scaleXY (2, 2) $ scaleX 2 $ rect (20, 30)
          ]
    , comment "Resize" $
        spreadX
          [ rect (20, 30)
          , resizeX 40 $ rect (20, 30)
          , resizeY 60 $ resizeX 20 $ rect (20, 30)
          , resizeXY (40, 60) $ resizeX 20 $ rect (20, 30)
          ]
    , comment "Rotate" $
        spreadX
          [ rect (50, 30)
          , spinZ 45 $ rect (50, 30)
          , spinZ 90 $ rect (50, 30)
          , spinZ 135 $ rect (50, 30)
          , spinZ 180 $ rect (50, 30)
          , spinZ 225 $ rect (50, 30)
          , spinZ 270 $ rect (50, 30)
          , spinZ 315 $ rect (50, 30)
          , spinZ 360 $ rect (50, 30)
          ]
    , comment "Mirror" $
        spreadX
          [ rect (50, 30)
          , mirrorX $ rect (50, 30)
          ]
    , comment "Color" $
        spreadX
          [ rect (50, 30)
          , colorRGB (1, 0, 0) $ rect (50, 30)
          , colorRGBA (1, 0, 0) 0.5 $ rect (50, 30)
          ]
    , comment "Text" $
        spreadX
          [ text "Hello, World!" defaultTextOpts
          -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationMono })
          -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSans })
          -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSerif })
          -- , text "Hello, World!" (defaultTextOpts { textFont = FNCustom "Arial" })
          ]
    , -- TODO: offset examples
      spreadX
        [ hull $
            unions
              [ modHighlight $ moveXY (50, 50) $ squareCenter 50
              , modHighlight $ circleD 50
              ]
        ]
    , spreadX
        [ difference
            (id $ moveXY (50, 50) $ squareCenter 50)
            (modTransparent $ circleD 100)
        ]
    ]
draw :: (MonadNeon m) => m Model2D
draw = unions [drawSamples, drawGrid]

main :: IO ()
main = do
  writeFile
    "renderings/01.scad"
    ( render2D $
        runNeonM defaultFacets draw
    )
