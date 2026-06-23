{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Move brackets to avoid $" #-}

module Examples.SplitSolid where

import Data.Bifunctor (Bifunctor (..))
import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)
import Prelude hiding (length, mod)

axisToFn :: (MonadNeon m) => Axis -> (Double -> m Model3D -> m Model3D)
axisToFn = \case
  X -> moveX
  Y -> moveY
  Z -> moveZ

infinity :: Double
infinity = 1000

clear :: Double
clear = 0.1

splitSolid :: forall m. (MonadNeon m) => Axis -> m Model3D -> (m Model3D, m Model3D)
splitSolid ax model =
  (difference model s, intersection model s)
  where
    s :: m Model3D
    s = axisToFn ax (infinity / 2) $ box $ size (infinity, infinity, infinity)

example :: (MonadNeon m) => (m Model3D, m Model3D)
example =
  bimap after after $
    splitSolid Y $
      before $
        unions
          [ mod transparent $
              comment "tube" $
                difference
                  ( cylinder $
                      diameter dia <> height h
                  )
                  ( cylinder $
                      diameter (dia - wall) <> height (h + clear)
                  ),
            comment "rings" $
              distribute (axis Z <> length (h - 3)) $
                comment "ring" $
                  drawRing $
                    height 3.0 <> outerDiameter dia <> innerDiameter 3.0
          ]
  where
    dia = 60
    wall = 1.5
    h = 200
    degrees = 30
    before = spinX degrees
    after = spinX (-degrees)

---

data DrawRingOpts = DrawRingOpts
  { drawRingOptsInnerDiameter :: Double,
    drawRingOptsOuterDiameter :: Double,
    drawRingOptsHeight :: Double
  }
  deriving (Eq)

instance Monoid DrawRingOpts where
  mempty =
    DrawRingOpts
      { drawRingOptsInnerDiameter = 80,
        drawRingOptsOuterDiameter = 100,
        drawRingOptsHeight = 0
      }

instance Semigroup DrawRingOpts where
  (<>) = semigroupDrawRingOpts

instance HasHeight Double DrawRingOpts where
  height v = mempty {drawRingOptsHeight = v}

instance HasInnerDiameter Double DrawRingOpts where
  innerDiameter v = mempty {drawRingOptsInnerDiameter = v}

instance HasOuterDiameter Double DrawRingOpts where
  outerDiameter v = mempty {drawRingOptsOuterDiameter = v}

---

drawRing :: (MonadNeon m) => DrawRingOpts -> m Model3D
drawRing opts =
  comment "ring" $
    difference
      ( comment "outer" $
          cylinder $
            diameter diaOuter <> height h
      )
      ( comment "inner" $
          cylinder $
            diameter diaInner <> height (h + clear * 2)
      )
  where
    diaInner = opts.drawRingOptsInnerDiameter
    diaOuter = opts.drawRingOptsOuterDiameter
    h = opts.drawRingOptsHeight

---

class HasInnerDiameter o a | a -> o where
  innerDiameter :: o -> a

class HasOuterDiameter o a | a -> o where
  outerDiameter :: o -> a

---

semigroupDrawRingOpts :: DrawRingOpts -> DrawRingOpts -> DrawRingOpts
semigroupDrawRingOpts a b =
  DrawRingOpts
    { drawRingOptsInnerDiameter =
        firstUnlessDefault (\x -> x.drawRingOptsInnerDiameter) a b,
      drawRingOptsOuterDiameter =
        firstUnlessDefault (\x -> x.drawRingOptsOuterDiameter) a b,
      drawRingOptsHeight =
        firstUnlessDefault (\x -> x.drawRingOptsHeight) a b
    }

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"

  let (m1, m2) = example

      m = unions [m1, m2]

  writeFile
    (docImgsPath ++ "/split-solid.scad")
    (render3D m)

  writeFile
    (docImgsPath ++ "/split-solid-1.scad")
    (render3D m1)

  writeFile
    (docImgsPath ++ "/split-solid-2.scad")
    (render3D m2)

---

firstUnlessDefault :: (Eq b, Monoid a) => (a -> b) -> a -> a -> b
firstUnlessDefault f a b =
  if f a == f mempty
    then f b
    else f a

---
