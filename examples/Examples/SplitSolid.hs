{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Move brackets to avoid $" #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}

module Examples.SplitSolid where

import Data.Maybe (mapMaybe)
import Data.Monoid (First (First), getFirst)
import Examples.Util.Colors (red)
import Examples.Util.Generic (SemigroupPlus, gSemigroupPlus)
import GHC.Generics (Generic)
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

type WithFn a = (a -> a) -> a -> a

data ChopSueyOpts m = ChopSueyOpts
  { transform :: First (WithFn (m Model3D)),
    length :: Double,
    count :: Int
  }
  deriving (Generic)

instance Semigroup (ChopSueyOpts m) where
  (<>) = gSemigroupPlus

instance Monoid (ChopSueyOpts m) where
  mempty =
    ChopSueyOpts
      { transform = First Nothing,
        length = 0,
        count = 0
      }

instance HasLength (ChopSueyOpts m) where
  length v = mempty {length = v}

instance HasCount (ChopSueyOpts m) where
  count v = mempty {count = v}

instance HasTransform (m Model3D) (ChopSueyOpts m) where
  transform v = mempty {transform = First $ Just v}

class HasTransform b a | a -> b where
  transform :: WithFn b -> a

chopSuey :: (MonadNeon m) => ChopSueyOpts m -> m Model3D -> [m Model3D]
chopSuey opts m =
  zipWith
    ( \(start, end) i ->
        comment ("slice " ++ show i) $
          with
            ( intersection
                (moveX start $ box $ size (V3 (end - start) infinity infinity) <> placeX origin)
            )
            m
    )
    (intervals (-d / 2) (d / 2) n)
    [0 ..]
  where
    d = opts.length
    n = opts.count
    with = case getFirst opts.transform of
      Just with -> with
      Nothing -> \_ -> id

example :: (MonadNeon m) => [m Model3D]
example =
  chopSuey
    (transform (withSpinZ 40) <> length 100 <> count 15)
    (spinX 15 $ spinY 15 $ box $ size (V3 60 30 20))

---

splitEvenOdd :: [a] -> ([a], [a])
splitEvenOdd xs =
  ( mapMaybe (\(x, i) -> if even i then Just x else Nothing) (zip xs [0 ..]),
    mapMaybe (\(x, i) -> if odd i then Just x else Nothing) (zip xs [0 ..])
  )

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"

  let (m1, m2) = splitEvenOdd example

  writeFile
    (docImgsPath ++ "/scad/split-solid.scad")
    (render3D $ unions [unions m1, mod transparent $ moveZ 10 $ unions m2])

  writeFile
    (docImgsPath ++ "/scad/split-solid-1.scad")
    (render3D $ unions m1)

  writeFile
    (docImgsPath ++ "/scad/split-solid-2.scad")
    (render3D $ unions m2)

---

firstUnlessDefault :: (Eq b, Monoid a) => (a -> b) -> a -> a -> b
firstUnlessDefault f a b =
  if f a == f mempty
    then f b
    else f a
