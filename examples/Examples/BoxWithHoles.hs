{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE NoFieldSelectors #-}

module Examples.BoxWithHoles where

import NeonCAD
import System.Environment (getEnv)
import Prelude hiding (mod)

data BoxWithHoles = BoxWithHoles
  { boxSize :: V3 Double,
    wallThickness :: Double,
    holeDiameter :: Double,
    holeAngles :: V3 Double,
    holePitch :: Double,
    infinity :: Double,
    holeFacets :: Int
  }

-------------------------------------------------------------------------------
-- Utils
-------------------------------------------------------------------------------

distribute :: (MonadNeon m) => (Double -> m Model3D -> m Model3D) -> Double -> Double -> m Model3D -> m Model3D
distribute move l fl model =
  move (-(fl / 2)) $
    unions
      (map (\i -> move (fromIntegral i * l) model) [0 .. n])
  where
    n = floor (fl / l) - 1

distributeX :: (MonadNeon m) => Double -> Double -> m Model3D -> m Model3D
distributeX = distribute moveX

distributeY :: (MonadNeon m) => Double -> Double -> m Model3D -> m Model3D
distributeY = distribute moveY

-------------------------------------------------------------------------------
-- Draw Functions
-------------------------------------------------------------------------------

drawPerforation :: (MonadNeon m) => BoxWithHoles -> m Model3D
drawPerforation opts =
  spinXYZ angles $
    distributeX pitch infinity $
      distributeY pitch infinity $
        cylinder $
          diameter dia
            <> height infinity
            <> facets (count opts.holeFacets)
  where
    infinity = opts.infinity
    angles = opts.holeAngles
    pitch = opts.holePitch
    dia = opts.holeDiameter

drawBox :: (MonadNeon m) => BoxWithHoles -> m Model3D
drawBox opts =
  difference
    ( box $
        size opts.boxSize
    )
    ( moveZ opts.wallThickness $
        box $
          size
            ( x - (opts.wallThickness * 2),
              y - (opts.wallThickness * 2),
              z
            )
    )
  where
    (x, y, z) = opts.boxSize

drawBoxWithHoles :: (MonadNeon m) => BoxWithHoles -> m Model3D
drawBoxWithHoles opts =
  difference
    (drawBox opts)
    (drawPerforation opts)

example :: (MonadNeon m) => m Model3D
example =
  drawBoxWithHoles $
    BoxWithHoles
      { boxSize = (80, 80, 80),
        wallThickness = 5,
        holeDiameter = 7,
        holeAngles = (45, 0, 45),
        holePitch = 10,
        infinity = 200,
        holeFacets = 20
      }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/box-with-holes.scad")
    (render3D example)
