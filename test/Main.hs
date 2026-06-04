{-# OPTIONS_GHC -Wno-missing-signatures #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

module Main (main) where

import NeonCAD

type Example m = (String, m Model3D)

drawExamples :: (MonadNeon m) => [(String, [Example m])] -> m Model3D
drawExamples ys =
  unions $
    zipWith
      ( \iy (nameY, xs) ->
          comment nameY $
            moveY (iy * 210) $
              unions
                [ moveX (-200) $
                    scale 2 $
                      extrudeLinear (height 2) $
                        text $
                          str nameY
                , unions (zipWith (\ix it -> moveX (ix * 210) $ drawExample it) [0 ..] xs)
                ]
      )
      [0 ..]
      ys

drawExample :: (MonadNeon m) => Example m -> m Model3D
drawExample (name, modelM) =
  comment name $
    unions
      [ moveZ (-5) $
          unions
            [ comment "Field" $
                unions
                  [ comment "Background" $
                      color (rgb white) $
                        moveZ (-1) $
                          extrudeLinear (height 1) $
                            square $
                              size 200
                  , comment "Label" $
                      moveXY (-100 + 10, -100 + 10) $
                        color (rgb red) $
                          extrudeLinear (height 1) $
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
blue = (0.298, 0.471, 0.659) :: V3 Double
orange = (0.961, 0.522, 0.094) :: V3 Double
green = (0.329, 0.635, 0.294) :: V3 Double
red = (0.894, 0.341, 0.337) :: V3 Double
purple = (0.698, 0.475, 0.635) :: V3 Double
teal = (0.447, 0.718, 0.698) :: V3 Double
gray = (0.498, 0.498, 0.498) :: V3 Double
brown = (0.616, 0.459, 0.353) :: V3 Double
olive = (0.580, 0.584, 0.192) :: V3 Double
pink = (0.906, 0.541, 0.765) :: V3 Double
cyan = (0.337, 0.706, 0.914) :: V3 Double
gold = (0.855, 0.647, 0.125) :: V3 Double
lime = (0.565, 0.753, 0.263) :: V3 Double
lavender = (0.729, 0.624, 0.859) :: V3 Double
coral = (0.929, 0.490, 0.192) :: V3 Double
white = (1, 1, 1) :: V3 Double

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

colorize :: (MonadNeon m, Color (m model)) => [m model] -> [m model]
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
to3D model = extrudeLinear (height 0.8) $ difference (offset 0.5 model) (offset (-0.5) model)

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
                [ circle $ diameter 50 <> origin
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
                [ rect $ size (50, 30) <> origin
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
            [ to3D $ square $ size 50 <> origin
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
  ,
    ( "Frustum"
    ,
      [
        ( "Default"
        , frustum mempty
        )
      ]
    )
  ,
    ( "Cylinder"
    ,
      [
        ( "Default"
        , cylinder mempty
        )
      ]
    )
  ,
    ( "Polyhedron"
    ,
      [
        ( "Default"
        , polyhedron mempty
        )
      ]
    )
  ]

world :: (MonadNeon m) => m Model3D
world =
  unions
    [ drawExamples info2D
    , moveX 1000 $ drawExamples info3D
    ]

main :: IO ()
main = do
  writeFile
    "out/visual-test.scad"
    ( render3D $
        runNeonM defaultFacets world
    )
