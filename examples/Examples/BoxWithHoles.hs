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

spread :: (MonadNeon m) => (Double -> m Model3D -> m Model3D) -> Double -> Double -> m Model3D -> m Model3D
spread move l fl model =
  move (-(fl / 2)) $
    unions
      (map (\i -> move (fromIntegral i * l) model) [0 .. n])
  where
    n = floor (fl / l) - 1

perforation :: (MonadNeon m) => BoxWithHoles -> m Model3D
perforation opts =
  spinXYZ opts.holeAngles $
    spread moveX opts.holePitch opts.infinity $
      spread moveY opts.holePitch opts.infinity $
        cylinder $
          diameter opts.holeDiameter
            <> height opts.infinity
            <> facets (count opts.holeFacets)

myBox :: (MonadNeon m) => BoxWithHoles -> m Model3D
myBox opts =
  difference
    ( box $
        size opts.boxSize
          <> place center
    )
    ( moveZ opts.wallThickness $
        box $
          size
            ( x - (opts.wallThickness * 2),
              y - (opts.wallThickness * 2),
              z
            )
            <> place center
    )
  where
    (x, y, z) = opts.boxSize

boxWithHoles :: (MonadNeon m) => BoxWithHoles -> m Model3D
boxWithHoles opts =
  difference
    (myBox opts)
    (perforation opts)

example :: (MonadNeon m) => m Model3D
example =
  boxWithHoles $
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
  print "Generating box with holes example"
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/box-with-holes.scad")
    (render3D example)
