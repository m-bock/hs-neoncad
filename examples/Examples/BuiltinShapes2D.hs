module Examples.BuiltinShapes2D where

import Examples.Util.Colors
import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)

to3D :: (MonadNeon m) => m Model2D -> m Model3D
to3D model = extrudeLinear (height 0.8) $ difference (offset 0.5 model) (offset (-0.5) model)

colorize :: (MonadNeon m) => [m Model3D] -> [m Model3D]
colorize models =
  zipWith3
    ( \c model i ->
        comment ("color " <> show i) $
          color (rgb c <> alpha 0.7) model
    )
    colors
    models
    [0 ..]

drawExamples :: (MonadNeon m) => [Row m] -> m Model3D
drawExamples rows = distribute (place origin <> axis X <> pitch 250) (map drawRow rows)

drawRow :: (MonadNeon m) => Row m -> m Model3D
drawRow (name, cells) =
  comment ("row " <> name) $
    unions
      [ comment "row label" $
          moveX (-100) $
            moveY (-170) $
              scale 2 $
                extrudeLinear (height 2) $
                  text name mempty,
        comment "cells" $
          distribute (place origin <> axis Y <> pitch 230) (map drawCell cells)
      ]

drawCell :: (MonadNeon m) => Cell m -> m Model3D
drawCell (name, modelsM) =
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
                              size 200,
                    comment "Label" $
                      moveXY (vec (-100 + 10, -100 + 10)) $
                        color (rgb red) $
                          extrudeLinear (height 1) $
                            text name mempty,
                    comment "Axis" $
                      color (rgb red) $
                        unions
                          [ comment "X" $ box $ size $ vec (1, 200, 1),
                            comment "Y" $ box $ size $ vec (200, 1, 1),
                            comment "Z" $ box $ size $ vec (1, 1, 200)
                          ]
                  ],
              comment "Model" (unions $ colorize $ map to3D modelsM)
            ]
      ]

-- \$ modelM

type Row m = (String, [Cell m])

type Cell m = (String, [m Model2D])

examples :: (MonadNeon m) => [Row m]
examples =
  [ ( "Circle",
      [ ( "Default",
          [circle $ radius 50]
        ),
        ( "radius vs diameter",
          [ circle $ radius 50,
            circle $ diameter 50
          ]
        ),
        ( "placements",
          [ circle $ diameter 50 <> placeXY origin,
            circle $ diameter 50 <> placeXY center
          ]
        )
      ]
    ),
    ( "Ellipse",
      [ ( "Default",
          [ellipse mempty]
        ),
        ( "placements",
          [ ellipse $ size (V2 50 30) <> placeXY origin,
            ellipse $ size (V2 50 30) <> placeXY center
          ]
        )
      ]
    ),
    ( "Rect",
      [ ( "Default",
          [rect mempty]
        ),
        ( "Size, (50, 30)",
          [rect $ size (V2 50 30)]
        ),
        ( "placements",
          [ rect $ size (V2 50 30) <> placeXY origin,
            rect $ size (V2 50 30) <> placeXY center
          ]
        )
      ]
    ),
    ( "Square",
      [ ( "Default",
          [square mempty]
        ),
        ( "Sizes",
          map (square . size) [20, 40, 60, 80, 100]
        ),
        ( "placements",
          [ square $ size 50 <> placeXY origin,
            square $ size 50 <> placeXY center
          ]
        )
      ]
    ),
    ( "Polygon",
      [ ( "Default",
          [polygon mempty]
        )
      ]
    ),
    ( "Text",
      [ ( "Default",
          [text "Hello, World!" mempty]
        )
      ]
    )
  ]

example :: (MonadNeon m) => m Model3D
example = drawExamples examples

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/scad/builtin-shapes-2d.scad")
    (render3D example)
