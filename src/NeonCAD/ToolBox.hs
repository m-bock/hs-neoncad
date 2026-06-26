{-# OPTIONS_GHC -Wno-type-defaults #-}

module NeonCAD.ToolBox
  ( Axis (..),
    DistributeOpts,
    distribute,
    HasAxis (axis),
    HasLength (length),
    HasPitch (pitch),
    HasPlacement (place),
    intervals,
    eps,
  )
where

import NeonCAD
import Prelude as P

data Axis = X | Y | Z deriving (Eq)

data Length = FullLength Double | Pitch Double deriving (Eq)

data DistributeOpts = DistributeOpts
  { axis :: Axis,
    length :: Length,
    placement :: Placement
  }

instance Monoid DistributeOpts where
  mempty =
    DistributeOpts
      { axis = X,
        length = Pitch 10,
        placement = center
      }

instance Semigroup DistributeOpts where
  (<>) = semigroupDistributeOpts

instance HasAxis DistributeOpts where
  axis v = mempty {axis = v}

instance HasLength DistributeOpts where
  length v = mempty {length = FullLength v}

instance HasPitch DistributeOpts where
  pitch v = mempty {length = Pitch v}

instance HasPlacement DistributeOpts where
  place v = mempty {placement = v}

distribute :: (MonadNeon m) => DistributeOpts -> [m Model3D] -> m Model3D
distribute opts modelsM = do
  handleMove $
    unions
      (zipWith (\i modelM -> move (fromIntegral i * pitch) modelM) [0 ..] modelsM)
  where
    (pitch, fullLength) = case opts.length of
      FullLength l -> (l / fromIntegral (n - 1), l)
      Pitch p -> (p, p * fromIntegral (n - 1))

    move = case opts.axis of
      X -> moveX
      Y -> moveY
      Z -> moveZ

    n = P.length modelsM

    handleMove = if opts.placement == center then move (-fullLength / 2) else id

class HasAxis a where
  axis :: Axis -> a

class HasLength a where
  length :: Double -> a

class HasPitch a where
  pitch :: Double -> a

class HasPlacement a where
  place :: Placement -> a

---

intervals :: Double -> Double -> Int -> [(Double, Double)]
intervals start end n =
  map (mkInterval . fromIntegral) [0 .. n - 1]
  where
    mkInterval i =
      ( start + i * step,
        start + (i + 1) * step
      )

    len = end - start
    step = len / fromIntegral n

---

semigroupDistributeOpts :: DistributeOpts -> DistributeOpts -> DistributeOpts
semigroupDistributeOpts a b =
  DistributeOpts
    { axis =
        firstUnlessDefault (\x -> x.axis) a b,
      length =
        firstUnlessDefault (\x -> x.length) a b,
      placement =
        firstUnlessDefault (\x -> x.placement) a b
    }

---

firstUnlessDefault :: (Eq b, Monoid a) => (a -> b) -> a -> a -> b
firstUnlessDefault f a b =
  if f a == f mempty
    then f b
    else f a

---

eps :: Double
eps = 0.05