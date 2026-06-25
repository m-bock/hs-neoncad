{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Move brackets to avoid $" #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}

module Examples.SplitSolid where

import Data.Bifunctor (Bifunctor (..))
import Data.Maybe (mapMaybe)
import Data.Monoid (First (..))
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
    s = axisToFn ax (infinity / 2) $ box $ size (V3 infinity infinity infinity)

splitSolid' :: forall m. (MonadNeon m) => m Model3D -> m Model3D -> (m Model3D, m Model3D)
splitSolid' splitModelM modelM =
  (difference modelM splitModelM, intersection modelM splitModelM)

j :: (MonadNeon m) => Axis -> m Model3D
j ax = axisToFn ax (infinity / 2) $ box $ size (V3 infinity infinity infinity)

type WithFn a = (a -> a) -> a -> a

splitSolidWith :: (MonadNeon m) => WithFn (m Model3D) -> m Model3D -> m Model3D -> (m Model3D, m Model3D)
splitSolidWith withFn splitModel modelM =
  ( withFn (intersection splitModel) modelM,
    withFn (\m -> difference m splitModel) modelM
  )

---

splitSolidWith' :: (MonadNeon m) => WithFn (m Model3D) -> m Model3D -> m Model3D -> (m Model3D, m Model3D)
splitSolidWith' withFn splitModel modelM =
  ( withFn (intersection splitModel) modelM,
    withFn (\m -> difference m splitModel) modelM
  )

---

chopSuey :: (MonadNeon m) => WithFn (m Model3D) -> Double -> Int -> m Model3D -> [m Model3D]
chopSuey with d n m =
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

example :: (MonadNeon m) => [m Model3D]
example = chopSuey (withSpinZ 20) 200.0 20 (box $ size (V3 100 100 100))

---

evenOdds :: [a] -> ([a], [a])
evenOdds xs =
  ( mapMaybe (\(x, i) -> if even i then Just x else Nothing) (zip xs [0 ..]),
    mapMaybe (\(x, i) -> if odd i then Just x else Nothing) (zip xs [0 ..])
  )

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"

  let (m1, m2) = evenOdds example

  writeFile
    (docImgsPath ++ "/split-solid.scad")
    (render3D $ unions [unions m1, mod transparent $ unions m2])

  writeFile
    (docImgsPath ++ "/split-solid-1.scad")
    (render3D $ unions m1)

  writeFile
    (docImgsPath ++ "/split-solid-2.scad")
    (render3D $ unions m2)

---

firstUnlessDefault :: (Eq b, Monoid a) => (a -> b) -> a -> a -> b
firstUnlessDefault f a b =
  if f a == f mempty
    then f b
    else f a
