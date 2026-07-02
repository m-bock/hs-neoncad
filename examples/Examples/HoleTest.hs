{-# LANGUAGE BlockArguments #-}

module Examples.HoleTest where

import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)
import Text.Printf (printf)
import Prelude hiding (mod)
import Prelude qualified as P

example :: (MonadNeon m) => m Model3D
example =
  spinZ (-90) $
    unions
      [ comment "main bar" $
          moveY (wid / 2) $
            difference
              (comment "solid" $ box $ size (V3 len wid hei) <> placeZ origin)
              ( comment "holes" $
                  distribute (pitch pit) $
                    flip map diameters \dia ->
                      moveZ (-eps) $
                        comment "hole" $
                          cylinder $
                            diameter dia <> height (hei + eps * 2) <> placeZ origin
              ),
        comment "label bar" $
          moveY wid $
            unions
              [ box $ size (V3 len 15 socketHei) <> placeY origin <> placeZ origin,
                distribute (pitch pit) $
                  flip map diameters \dia ->
                    moveY 1 $
                      spinZ 90 $
                        extrudeLinear (height (fontHei + socketHei)) $
                          text (printf "%.2f" dia) $
                            size 4 <> vAlign center
              ]
      ]
  where
    pit = 11
    len = fromIntegral testCount * pit + 5
    hei = 5
    wid = 12
    fontHei = 0.5
    socketHei = 1.5

    testStep = 0.2
    testCount = P.length diameters

    diameters = getSteps 7 9 testStep

getSteps :: Double -> Double -> Double -> [Double]
getSteps from to step = [from, from + step .. to]

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/scad/hole-test.scad")
    (render3D example)
