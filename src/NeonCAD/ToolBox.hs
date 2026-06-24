{-# OPTIONS_GHC -Wno-type-defaults #-}

module NeonCAD.ToolBox
  ( Axis (..),
    DistributeOpts,
    distribute,
    HasAxis (axis),
    HasLength (length),
    HasPitch (pitch),
    HasPlacement (place),
  )
where

import NeonCAD
import Prelude as P

data Axis = X | Y | Z deriving (Eq)

data Length = FullLength Double | Pitch Double deriving (Eq)

data DistributeOpts = DistributeOpts
  { distributeOptsAxis :: Axis,
    distributeOptsLength :: Length,
    distributeOptsPlacement :: Placement
  }

instance Monoid DistributeOpts where
  mempty =
    DistributeOpts
      { distributeOptsAxis = X,
        distributeOptsLength = Pitch 10,
        distributeOptsPlacement = center
      }

instance Semigroup DistributeOpts where
  (<>) = semigroupDistributeOpts

instance HasAxis DistributeOpts where
  axis v = mempty {distributeOptsAxis = v}

instance HasLength DistributeOpts where
  length v = mempty {distributeOptsLength = FullLength v}

instance HasPitch DistributeOpts where
  pitch v = mempty {distributeOptsLength = Pitch v}

instance HasPlacement DistributeOpts where
  place v = mempty {distributeOptsPlacement = v}

distribute :: (MonadNeon m) => DistributeOpts -> [m Model3D] -> m Model3D
distribute opts modelsM = do
  handleMove $
    unions
      (zipWith (\i modelM -> move (fromIntegral i * pitch) modelM) [0 ..] modelsM)
  where
    (pitch, fullLength) = case opts.distributeOptsLength of
      FullLength l -> (l / fromIntegral (n - 1), l)
      Pitch p -> (p, p * fromIntegral (n - 1))

    move = case opts.distributeOptsAxis of
      X -> moveX
      Y -> moveY
      Z -> moveZ

    n = P.length modelsM

    handleMove = if opts.distributeOptsPlacement == center then move (-fullLength / 2) else id

class HasAxis a where
  axis :: Axis -> a

class HasLength a where
  length :: Double -> a

class HasPitch a where
  pitch :: Double -> a

class HasPlacement a where
  place :: Placement -> a

---

semigroupDistributeOpts :: DistributeOpts -> DistributeOpts -> DistributeOpts
semigroupDistributeOpts a b =
  DistributeOpts
    { distributeOptsAxis =
        firstUnlessDefault (\x -> x.distributeOptsAxis) a b,
      distributeOptsLength =
        firstUnlessDefault (\x -> x.distributeOptsLength) a b,
      distributeOptsPlacement =
        firstUnlessDefault (\x -> x.distributeOptsPlacement) a b
    }

---

firstUnlessDefault :: (Eq b, Monoid a) => (a -> b) -> a -> a -> b
firstUnlessDefault f a b =
  if f a == f mempty
    then f b
    else f a

---
