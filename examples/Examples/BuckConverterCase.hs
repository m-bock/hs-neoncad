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

twice :: Double -> Double
twice x = x * 2

half :: Double -> Double
half x = x / 2

_x :: V3 a -> a
_x (x, _, _) = x

_y :: V3 a -> a
_y (_, y, _) = y

_z :: V3 a -> a
_z (_, _, z) = z

clear :: Double
clear = 0.1

drawBuckConverterCase :: (MonadNeon m) => BuckConverterCase -> m Model3D
drawBuckConverterCase opts =
  let lidOuterWidth = opts.bcOuterWidth
      lidOuterDepth = opts.bcOuterDepth
      lidOuterHeight = opts.bcOuterHeight

      lidInnerWidth = lidOuterWidth - twice opts.bcWall
      lidInnerDepth = lidOuterDepth - twice opts.bcWall
      lidInnerHeight = lidOuterHeight - opts.bcWall

      baseOuterWidth = lidInnerWidth - twice opts.bcGap
      baseOuterDepth = lidInnerDepth - twice opts.bcGap
      baseOuterHeight = lidInnerHeight - opts.bcGap

      baseInnerWidth = baseOuterWidth - twice opts.bcWall
      baseInnerDepth = baseOuterDepth - twice opts.bcWall
      baseInnerHeight = baseOuterHeight - opts.bcWall
   in unions
        [ moveY 50 $
            difference
              ( box $
                  size
                    ( lidOuterWidth,
                      lidOuterDepth,
                      lidOuterHeight
                    )
                    <> placeZ origin
              )
              ( mod highlight $
                  moveZ (negate clear) $
                    box $
                      size
                        ( lidInnerWidth,
                          lidInnerDepth,
                          lidInnerHeight + clear
                        )
                        <> placeZ origin
              ),
          differences
            ( box $
                size (baseOuterWidth, baseOuterDepth, baseOuterHeight)
                  <> placeZ origin
            )
            [ mod highlight $
                moveZ opts.bcWall $
                  box $
                    size (baseInnerWidth, baseInnerDepth, baseInnerHeight + clear)
                      <> placeZ origin
            ]
        ]

-- moveZ opts.bcWall $
--   box $
--     size
--       ( opts.bcOuterWidth - 2 * opts.bcWall,
--         opts.bcOuterDepth - (opts.bcPillarSize * 2),
--         opts.bcOuterHeight
--       ),
-- -- <> place center,
-- moveZ
--   opts.bcWall
--   $ box
--   $ size
--     ( opts.bcOuterWidth - (opts.bcPillarSize * 2),
--       opts.bcOuterDepth - 2 * opts.bcWall,
--       opts.bcOuterHeight
--     ),
-- -- <> place center

-- spinY 90 $ cylinder $ height opts.bcInfinity <> diameter opts.bcPillarSize, -- <> place center,
-- moveZ (opts.bcOuterHeight / 2) $
--   spinX 90 $
--     extrudeLinear center $
--       ellipse $
--         size
--           ( opts.bcOuterWidth - (opts.bcPillarSize * 2),
--             (opts.bcOuterHeight * 2) - (opts.bcWall * 4)
--           ),
-- -- <> place center

-- let screw =
--       moveZ ((opts.bcOuterHeight / 2) - opts.bcScrewHeight) $
--         cylinder $
--           height (opts.bcScrewHeight + opts.bcGap) <> diameter opts.bcScrewDia --  <> place origin
--     p2 = opts.bcPillarSize / 2
--     d2 = (opts.bcOuterDepth / 2) - p2
--     w2 = (opts.bcOuterWidth / 2) - p2
--  in unions
--       [ moveXY (-w2, d2) screw,
--         moveXY (w2, d2) screw,
--         moveXY (-w2, -d2) screw,
--         moveXY (w2, -d2) screw
--       ]

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
        bcGap = 1
      }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/buck-converter-case.scad")
    (render3D example)
