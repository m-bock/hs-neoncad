{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE NoFieldSelectors #-}

module Examples.BoxWithHoles where

import NeonCAD
import System.Environment (getEnv)
import Prelude hiding (mod)

data BoxWithHoles = BoxWithHoles
    { boxSize :: V3 Int
    , wallThickness :: Double
    , holeDiameter :: Double
    , holeAngles :: V3 Double
    }

infinity :: Double
infinity = 100

cheeze :: (MonadNeon m) => m Model3D -> m Model3D
cheeze model =
    difference model $
        mod highlight $
            spinXYZ (45, 0, 45) $
                spreadX 10 (infinity) $
                    spreadY 10 (infinity) $
                        cylinder $
                            diameter 7 <> height infinity

spreadX :: (MonadNeon m) => Double -> Double -> m Model3D -> m Model3D
spreadX l fl model =
    moveX (-(fl / 2)) $
        unions
            (map (\i -> moveX (fromIntegral i * l) model) [0 .. n])
  where
    n = floor (fl / l) - 1

spreadY :: (MonadNeon m) => Double -> Double -> m Model3D -> m Model3D
spreadY l fl model =
    moveY (-(fl / 2)) $
        unions
            (map (\i -> moveY (fromIntegral i * l) model) [0 .. n])
  where
    n = floor (fl / l) - 1

extra :: Double
extra = 2

boxWithHoles :: (MonadNeon m) => BoxWithHoles -> m Model3D
boxWithHoles opts =
    difference
        ( box $
            size (fromIntegral x, fromIntegral y, fromIntegral z)
                <> place center
        )
        ( moveZ wallThickness $
            box $
                size
                    ( fromIntegral x - (wallThickness * 2)
                    , fromIntegral y - (wallThickness * 2)
                    , fromIntegral z
                    )
                    <> place center
        )
  where
    wallThickness = 5
    (x, y, z) = opts.boxSize

example :: (MonadNeon m) => m Model3D
example = cheeze $ boxWithHoles $ BoxWithHoles{boxSize = (50, 50, 50)}

main :: IO ()
main = do
    print "Generating box with holes example"
    docImgsPath <- getEnv "EXAMPLES_DIR"
    writeFile
        (docImgsPath ++ "/box-with-holes.scad")
        (render3D example)
