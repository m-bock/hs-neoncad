{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE NoFieldSelectors #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Avoid lambda using `infix`" #-}

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
    bcGap :: Double,
    bcHoleDia :: Double
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
      baseInnerHeight = baseOuterHeight - wall

      wall = opts.bcWall
      pillarSize = opts.bcPillarSize
      screwSize = opts.bcScrewDia
      screwHeight = opts.bcScrewHeight
      holeDia = opts.bcHoleDia
      gap = opts.bcGap
      isPrint = True

      drawLid =
        comment "lid" $
          differences
            ( comment "outer box" $
                box $
                  size
                    ( lidOuterWidth,
                      lidOuterDepth,
                      lidOuterHeight
                    )
                    <> placeZ origin
            )
            [ comment "inner box" $
                moveZ (negate clear) $
                  box $
                    size
                      ( lidInnerWidth,
                        lidInnerDepth,
                        lidInnerHeight + clear
                      )
                      <> placeZ origin,
              comment "screw holes" $
                unions $
                  flip map vs $ \v ->
                    moveXY v $
                      comment "screw hole" $
                        cylinder $
                          diameter (screwSize + gap) <> height opts.bcInfinity,
              comment "tunnel" $
                spinY 90 $
                  extrudeLinear center $
                    ellipse $
                      size (twice lidOuterHeight - 4 * wall, lidOuterDepth - twice wall)
            ]

      drawBaseBox =
        comment "base box" $
          differences
            ( box $
                size (baseOuterWidth, baseOuterDepth, baseOuterHeight)
                  <> placeZ origin
            )
            [ moveZ opts.bcWall $
                box $
                  size (baseInnerWidth, baseInnerDepth, baseInnerHeight + clear)
                    <> placeZ origin
            ]

      drawPillarPos =
        comment "pillar" $
          box $
            size
              ( opts.bcPillarSize,
                opts.bcPillarSize,
                baseOuterHeight
              )
              <> placeZ origin

      drawScrewHolder =
        comment "screw holder" $
          moveZ (baseOuterHeight - screwHeight) $
            cylinder $
              diameter (screwSize + gap) <> height (screwHeight + clear) <> placeZ origin

      drawHalfPipe =
        comment "half pipe" $
          moveZ (baseOuterHeight + twice wall) $
            spinX 90 $
              extrudeLinear (height (baseOuterDepth + twice clear) <> center) $
                mod highlight $
                  ellipse $
                    size
                      ( baseOuterWidth - twice wall,
                        twice baseOuterHeight
                      )

      x = half baseOuterWidth - half pillarSize
      y = half baseOuterDepth - half pillarSize
      vs =
        [(x, y), (x, -y), (-x, y), (-x, -y)]
   in unions
        [ ( if isPrint
              then
                moveY (twice lidOuterDepth)
                  . moveZ lidOuterHeight
                  . spinX 180
              else id
          )
            drawLid,
          differences
            ( unions
                [ comment "wall" $
                    difference drawBaseBox drawHalfPipe,
                  comment "pillars" $
                    unions (map (\v -> moveXY v drawPillarPos) vs)
                ]
            )
            [ comment "wire holes" $
                moveZ (half baseOuterHeight) $
                  spinY 90 $
                    cylinder $
                      diameter holeDia <> height opts.bcInfinity,
              comment "screw holders" $
                unions (map (\v -> moveXY v drawScrewHolder) vs)
            ]
        ]

example :: (MonadNeon m) => m Model3D
example =
  drawBuckConverterCase $
    BuckConverterCase
      { bcWall = 1.5,
        bcOuterWidth = 70,
        bcOuterDepth = 40,
        bcOuterHeight = 20,
        bcPillarSize = 4,
        bcInfinity = 200,
        bcScrewDia = 2,
        bcScrewHeight = 15,
        bcGap = 0.5,
        bcHoleDia = 4
      }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/buck-converter-case.scad")
    (render3D example)
