{-# HLINT ignore "Avoid lambda using `infix`" #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE NoFieldSelectors #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

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

drawBuckConverterCase :: forall m. (MonadNeon m) => BuckConverterCase -> m Model3D
drawBuckConverterCase opts =
  let lidOuterWidth = opts.bcOuterWidth :: Double
      lidOuterDepth = opts.bcOuterDepth :: Double
      lidOuterHeight = opts.bcOuterHeight :: Double

      lidInnerWidth = lidOuterWidth - twice opts.bcWall :: Double
      lidInnerDepth = lidOuterDepth - twice opts.bcWall :: Double
      lidInnerHeight = lidOuterHeight - opts.bcWall :: Double

      baseOuterWidth = lidInnerWidth - twice opts.bcGap :: Double
      baseOuterDepth = lidInnerDepth - twice opts.bcGap :: Double
      baseOuterHeight = lidInnerHeight - opts.bcGap :: Double

      baseInnerWidth = baseOuterWidth - twice opts.bcWall :: Double
      baseInnerDepth = baseOuterDepth - twice opts.bcWall :: Double
      baseInnerHeight = baseOuterHeight - wall :: Double

      wall = opts.bcWall :: Double
      pillarSize = opts.bcPillarSize :: Double
      screwSize = opts.bcScrewDia :: Double
      screwHeight = opts.bcScrewHeight :: Double
      holeDia = opts.bcHoleDia :: Double
      gap = opts.bcGap :: Double
      isPrint = True :: Bool

      x = half baseOuterWidth - half pillarSize :: Double
      y = half baseOuterDepth - half pillarSize :: Double
      vs = [(x, y), (x, -y), (-x, y), (-x, -y)] :: [(Double, Double)]

      drawLid :: m Model3D
      drawLid =
        comment "lid" $
          differences
            ( comment "outer box" $
                box $
                  size (V3 lidOuterWidth lidOuterDepth lidOuterHeight)
                    <> placeZ origin
            )
            [ comment "inner box" $
                moveZ (negate clear) $
                  box $
                    size (V3 lidInnerWidth lidInnerDepth (lidInnerHeight + clear))
                      <> placeZ origin,
              comment "screw holes" $
                unions $
                  flip map vs \v ->
                    moveXY (vec v) $
                      comment "screw hole" $
                        cylinder $
                          diameter (screwSize + gap) <> height opts.bcInfinity,
              comment "tunnel" $
                spinY 90 $
                  extrudeLinear center $
                    ellipse $
                      size $
                        vec (twice lidOuterHeight - 4 * wall, lidOuterDepth - twice wall)
            ]

      drawBase :: m Model3D
      drawBase =
        differences
          ( unions
              [ comment "wall" $
                  difference drawBaseBox drawHalfPipe,
                comment "pillars" $
                  unions (map (\v -> moveXY (vec v) drawPillar) vs)
              ]
          )
          [ comment "wire holes" $
              moveZ (half baseOuterHeight) $
                spinY 90 $
                  cylinder $
                    diameter holeDia <> height opts.bcInfinity,
            comment "screw holders" $
              unions (map (\v -> moveXY (vec v) drawScrewHolder) vs)
          ]

      drawBaseBox :: m Model3D
      drawBaseBox =
        comment "base box" $
          differences
            ( box $
                size (V3 baseOuterWidth baseOuterDepth baseOuterHeight)
                  <> placeZ origin
            )
            [ moveZ opts.bcWall $
                box $
                  size (V3 baseInnerWidth baseInnerDepth (baseInnerHeight + clear))
                    <> placeZ origin
            ]

      drawPillar :: m Model3D
      drawPillar =
        comment "pillar" $
          box $
            size (V3 pillarSize pillarSize baseOuterHeight)
              <> placeZ origin

      drawScrewHolder :: m Model3D
      drawScrewHolder =
        comment "screw holder" $
          moveZ (baseOuterHeight - screwHeight) $
            cylinder $
              diameter (screwSize + gap) <> height (screwHeight + clear) <> placeZ origin

      drawHalfPipe :: m Model3D
      drawHalfPipe =
        comment "half pipe" $
          moveZ (baseOuterHeight + twice wall) $
            spinX 90 $
              extrudeLinear (height (baseOuterDepth + twice clear) <> center) $
                mod highlight $
                  ellipse $
                    size $
                      vec (baseOuterWidth - twice wall, twice baseOuterHeight)
   in unions
        [ comment "place lid" $
            cond
              (isPrint, moveY 45 . moveZ lidOuterHeight . spinX 180)
              drawLid,
          drawBase
        ]

example :: (MonadNeon m) => m Model3D
example =
  drawBuckConverterCase $
    BuckConverterCase
      { bcWall = 1.5,
        bcOuterWidth = 60,
        bcOuterDepth = 35,
        bcOuterHeight = 20,
        bcPillarSize = 4,
        bcInfinity = 200,
        bcScrewDia = 2,
        bcScrewHeight = 5,
        bcGap = 0.5,
        bcHoleDia = 4
      }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/scad/buck-converter-case.scad")
    (render3D example)

-- utils

twice :: Double -> Double
twice x = x * 2

half :: Double -> Double
half x = x / 2

_x :: V3 a -> a
_x (V3 x _ _) = x

_y :: V3 a -> a
_y (V3 _ y _) = y

_z :: V3 a -> a
_z (V3 _ _ z) = z

clear :: Double
clear = 0.1

cond :: (Bool, a -> a) -> a -> a
cond (b, f) x = if b then f x else x