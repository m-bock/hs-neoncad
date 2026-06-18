{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE NoFieldSelectors #-}

module Examples.BuckConverterCase where

import NeonCAD
import System.Environment (getEnv)
import Prelude hiding (mod)

data BuckConverterCase = BuckConverterCase
  { bcWall :: Double,
    bcOuterWidth :: Double,
    bcOuterHeight :: Double,
    bcOuterDepth :: Double,
    bcPillarSize :: Double,
    bcInfinity :: Double,
    bcScrewDia :: Double,
    bcScrewHeight :: Double,
    bcGap :: Double
  }

drawBuckConverterCase :: (MonadNeon m) => BuckConverterCase -> m Model3D
drawBuckConverterCase opts =
  unions
    [ moveY opts.bcInfinity $
        difference
          ( box $
              size
                ( opts.bcOuterWidth + (opts.bcWall * 2) + (opts.bcGap * 2),
                  opts.bcOuterDepth + (opts.bcWall * 2) + (opts.bcGap * 2),
                  opts.bcOuterHeight + (opts.bcWall * 2) + (opts.bcGap * 2)
                )
                -- <> place center
          )
          ( mod highlight $
              moveZ (-opts.bcWall) $
                box $
                  size
                    ( opts.bcOuterWidth + (opts.bcGap * 2),
                      opts.bcOuterDepth + (opts.bcGap * 2),
                      opts.bcOuterHeight + (opts.bcGap * 2)
                    )
                    --    <> place origin
          ),
      differences
        ( box $
            size (opts.bcOuterWidth, opts.bcOuterDepth, opts.bcOuterHeight)
            -- <> place center
        )
        [ moveZ opts.bcWall $
            box $
              size
                ( opts.bcOuterWidth - 2 * opts.bcWall,
                  opts.bcOuterDepth - (opts.bcPillarSize * 2),
                  opts.bcOuterHeight
                ),
          -- <> place center,
          moveZ
            opts.bcWall
            $ box
            $ size
              ( opts.bcOuterWidth - (opts.bcPillarSize * 2),
                opts.bcOuterDepth - 2 * opts.bcWall,
                opts.bcOuterHeight
              ),
          -- <> place center

          spinY 90 $ cylinder $ height opts.bcInfinity <> diameter opts.bcPillarSize, -- <> place center,
          moveZ (opts.bcOuterHeight / 2) $
            spinX 90 $
              extrudeLinear center $
                ellipse $
                  size
                    ( opts.bcOuterWidth - (opts.bcPillarSize * 2),
                      (opts.bcOuterHeight * 2) - (opts.bcWall * 4)
                    ),
          -- <> place center

          let screw =
                moveZ ((opts.bcOuterHeight / 2) - opts.bcScrewHeight) $
                  cylinder $
                    height (opts.bcScrewHeight + opts.bcGap) <> diameter opts.bcScrewDia --  <> place origin
              p2 = opts.bcPillarSize / 2
              d2 = (opts.bcOuterDepth / 2) - p2
              w2 = (opts.bcOuterWidth / 2) - p2
           in unions
                [ moveXY (-w2, d2) screw,
                  moveXY (w2, d2) screw,
                  moveXY (-w2, -d2) screw,
                  moveXY (w2, -d2) screw
                ]
        ]
    ]

example :: (MonadNeon m) => m Model3D
example =
  drawBuckConverterCase $
    BuckConverterCase
      { bcWall = 2,
        bcOuterWidth = 50,
        bcOuterDepth = 30,
        bcOuterHeight = 20,
        bcPillarSize = 7,
        bcInfinity = 200,
        bcScrewDia = 3,
        bcScrewHeight = 15,
        bcGap = 2
      }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/buck-converter-case.scad")
    (render3D example)
