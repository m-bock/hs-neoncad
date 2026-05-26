module Main (main) where

import NeonCAD

magic :: (MonadNeon m) => [(String, [(String, m Model3D)])] -> m Model3D
magic ys =
  unions $
    zipWith
      ( \iy (nameY, xs) ->
          comment nameY $
            moveY (iy * 210) $
              unions
                [ moveX (-200) $ scale 2 $ extrudeLinear 2 $ text $ str nameY
                , unions (zipWith (\ix it -> moveX (ix * 210) $ magicOne it) [0 ..] xs)
                ]
      )
      [0 ..]
      ys

magicOne :: (MonadNeon m) => (String, m Model3D) -> m Model3D
magicOne (name, modelM) =
  comment name $
    unions
      [ moveZ (-5) $
          unions
            [ comment "Field" $
                unions
                  [ comment "Background" $
                      color (rgb white) $
                        moveZ (-1) $
                          extrudeLinear 1 $
                            square $
                              size 200
                  , comment "Label" $
                      moveXY (-100 + 10, -100 + 10) $
                        color (rgb red) $
                          extrudeLinear 1 $
                            text $
                              str name
                  , comment "Axis" $
                      color (rgb red) $
                        unions
                          [ comment "X" $ box $ size (1, 200, 1)
                          , comment "Y" $ box $ size (200, 1, 1)
                          , comment "Z" $ box $ size (1, 1, 200)
                          ]
                  ]
            , comment "Model" $ modelM
            ]
      ]

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
      [ moveZ (-5) $ color (rgb (1, 1, 1)) $ rect (size (190, 190)) -- <> centerXY)
      --   , moveZ (-4) $ colorRGBA (1, 0, 0) 0.5 $ unions [rect centerX, rect $ size (190, 1) <> centerXY]
      ]
 where
  x = fromIntegral x_
  y = fromIntegral y_

-- drawSamples :: (MonadNeon m) => m Model2D
-- drawSamples =
--   spreadY
--     [ comment "Circle" $
--         spreadX
--           [ comment "circleR" $ circle $ diameter 50
--           , comment "circleD" $ circle $ diameter 50
--           ]
--     , comment "Ellipse" $
--         spreadX
--           [ ellipseR (50, 30)
--           , ellipseD (50, 30)
--           ]
--     , comment "Rect" $
--         spreadX
--           [ rect (centerX)
--           , rect $ size (50, 30)
--           ]
--     , comment "Square" $
--         spreadX
--           [ square 50
--           , squareCenter 50
--           ]
--     , comment "Polygon" $
--         spreadX
--           [ polygon [(17, 17), (38, 33), (58, 15), (90, 35), (81, 75), (59, 59), (43, 68), (45, 80), (18, 86), (8, 46), (17, 17)]
--           ]
--     , comment "Scale" $
--         spreadX
--           [ rect $ size (20, 30)
--           , scaleX 2 $ rect $ size (20, 30)
--           , scaleY 2 $ scaleX 2 $ rect $ size (20, 30)
--           , scaleXY (2, 2) $ scaleX 2 $ rect $ size (20, 30)
--           ]
--     , comment "Resize" $
--         spreadX
--           [ rect $ size (20, 30)
--           , resizeX 40 $ rect $ size (20, 30)
--           , resizeY 60 $ resizeX 20 $ rect $ size (20, 30)
--           , resizeXY (40, 60) $ resizeX 20 $ rect $ size (20, 30)
--           ]
--     , comment "Rotate" $
--         spreadX
--           [ rect $ size (50, 30)
--           , spinZ 45 $ rect $ size (50, 30)
--           , spinZ 90 $ rect $ size (50, 30)
--           , spinZ 135 $ rect $ size (50, 30)
--           , spinZ 180 $ rect $ size (50, 30)
--           , spinZ 225 $ rect $ size (50, 30)
--           , spinZ 270 $ rect $ size (50, 30)
--           , spinZ 315 $ rect $ size (50, 30)
--           , spinZ 360 $ rect $ size (50, 30)
--           ]
--     , comment "Mirror" $
--         spreadX
--           [ rect $ size (50, 30)
--           , mirrorX $ rect $ size (50, 30)
--           ]
--     , comment "Color" $
--         spreadX
--           [ rect $ size (50, 30)
--           , colorRGB (1, 0, 0) $ rect $ size (50, 30)
--           , colorRGBA (1, 0, 0) 0.5 $ rect $ size (50, 30)
--           ]
--     , comment "Text" $
--         spreadX
--           [ text "Hello, World!"
--           -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationMono })
--           -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSans })
--           -- , text "Hello, World!" (defaultTextOpts { textFont = FNLiberationSerif })
--           -- , text "Hello, World!" (defaultTextOpts { textFont = FNCustom "Arial" })
--           ]
--     , -- TODO: offset examples
--       spreadX
--         [ hull $
--             unions
--               [ modHighlight $ moveXY (50, 50) $ squareCenter 50
--               , modHighlight $ circle (diameter 50)
--               ]
--         ]
--     , spreadX
--         [ difference
--             (id $ moveXY (50, 50) $ squareCenter 50)
--             (modTransparent $ circle (diameter 100))
--         ]
--     ]

-- draw :: (MonadNeon m) => m Model2D
-- draw = unions [drawSamples, drawGrid]

blue = (0.298, 0.471, 0.659)
orange = (0.961, 0.522, 0.094)
green = (0.329, 0.635, 0.294)
red = (0.894, 0.341, 0.337)
purple = (0.698, 0.475, 0.635)
teal = (0.447, 0.718, 0.698)
gray = (0.498, 0.498, 0.498)

brown = (0.616, 0.459, 0.353)
olive = (0.580, 0.584, 0.192)
pink = (0.906, 0.541, 0.765)
cyan = (0.337, 0.706, 0.914)
gold = (0.855, 0.647, 0.125)
lime = (0.565, 0.753, 0.263)
lavender = (0.729, 0.624, 0.859)
coral = (0.929, 0.490, 0.192)

white = (1, 1, 1)

colors =
  [ blue
  , orange
  , green
  , red
  , purple
  , teal
  , gold
  , pink
  , cyan
  , brown
  , lime
  , coral
  , lavender
  , olive
  , gray
  ]

colorize :: (MonadNeon m, Color model m) => [m model] -> [m model]
colorize models =
  zipWith
    ( \c model ->
        color (rgb c <> alpha 0.7) model
    )
    colors
    models

level :: (MonadNeon m) => [m Model2D] -> [m Model3D]
level models = map to3D models

to3D :: (MonadNeon m) => m Model2D -> m Model3D
to3D model = extrudeLinear 0.8 $ difference (offset 0.5 model) (offset (-0.5) model)

-- zipWith
--   ( \i model ->
--       moveZ i $ extrudeLinear 0.8 model
--   )
--   [0 ..]
--   models

info2D :: (MonadNeon m) => [(String, [(String, m Model3D)])]
info2D =
  [
    ( "Circle"
    ,
      [
        ( "Default"
        , to3D $ circle $ radius 50
        )
      ,
        ( "radius vs diameter"
        , unions $
            colorize $
              level
                [ circle $ radius 50
                , circle $ diameter 50
                ]
        )
      ,
        ( "placements"
        , unions $
            colorize $
              level
                [ circle $ diameter 50 <> corner
                , circle $ diameter 50 <> center
                ]
        )
      ]
    )
  ,
    ( "Ellipse"
    ,
      [
        ( "Default"
        , to3D $ ellipse mempty
        )
      ]
    )
  ,
    ( "Rect"
    ,
      [
        ( "Default"
        , to3D $ rect mempty
        )
      ,
        ( "Size, (50, 30)"
        , to3D $ rect $ size (50, 30)
        )
      ,
        ( "placements"
        , unions $
            colorize $
              level
                [ rect $ size (50, 30) <> corner
                , rect $ size (50, 30) <> center
                ]
        )
      ]
    )
  ,
    ( "Square"
    ,
      [
        ( "Default"
        , to3D $ square mempty
        )
      ,
        ( "Sizes"
        , unions $ map (\s -> to3D $ square $ size s) [20, 40, 60, 80, 100]
        )
      ,
        ( "placements"
        , unions $
            [ to3D $ square $ size 50 <> corner
            , to3D $ square $ size 50 <> center
            ]
        )
      ]
    )
  ,
    ( "Polygon"
    ,
      [
        ( "Default"
        , to3D $ polygon mempty
        )
      ]
    )
  ,
    ( "Text"
    ,
      [
        ( "Default"
        , to3D $ text mempty
        )
      ]
    )
  ]

info3D :: (MonadNeon m) => [(String, [(String, m Model3D)])]
info3D =
  [
    ( "Box"
    ,
      [
        ( "Default"
        , box mempty
        )
      ]
    )
  ,
    ( "Cube"
    ,
      [
        ( "Default"
        , cube mempty
        )
      ]
    )
  ,
    ( "Sphere"
    ,
      [
        ( "Default"
        , sphere mempty
        )
      ]
    )
  ,
    ( "Ellipsoid"
    ,
      [
        ( "Default"
        , ellipsoid mempty
        )
      ]
    )
  ]

world :: (MonadNeon m) => m Model3D
world =
  unions
    [ magic info2D
    , moveX 1000 $ magic info3D
    ]

main :: IO ()
main = do
  writeFile
    "renderings/01.scad"
    ( render3D $
        runNeonM defaultFacets world
    )
