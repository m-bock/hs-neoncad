module NeonCAD.ToolBox
  ( Axis (..),
    DistributeOpts,
    distribute,
    HasAxis (axis),
    HasLength (length),
  )
where

import NeonCAD

data Axis = X | Y | Z deriving (Eq)

data DistributeOpts = DistributeOpts
  { distributeOptsAxis :: Axis,
    distributeOptsCount :: Int,
    distributeOptsFullLength :: Double,
    distributeOptsPlacement :: Placement
  }

instance Monoid DistributeOpts where
  mempty =
    DistributeOpts
      { distributeOptsAxis = X,
        distributeOptsCount = 10,
        distributeOptsFullLength = 100,
        distributeOptsPlacement = center
      }

instance Semigroup DistributeOpts where
  (<>) = semigroupDistributeOpts

instance HasAxis Axis DistributeOpts where
  axis v = mempty {distributeOptsAxis = v}

instance HasLength Double DistributeOpts where
  length v = mempty {distributeOptsFullLength = v}

distribute :: (MonadNeon m) => DistributeOpts -> m Model3D -> m Model3D
distribute opts modelM = do
  handleMove $
    unions
      (map (\i -> move (fromIntegral i * s) modelM) [0 .. countSpaces])
  where
    l = opts.distributeOptsFullLength

    s = l / fromIntegral countSpaces

    countSpaces = n - 1

    move = case opts.distributeOptsAxis of
      X -> moveX
      Y -> moveY
      Z -> moveZ

    n = opts.distributeOptsCount

    handleMove = if opts.distributeOptsPlacement == center then move (-l / 2) else id

class HasAxis o a | a -> o where
  axis :: o -> a

class HasLength o a | a -> o where
  length :: o -> a

---

semigroupDistributeOpts :: DistributeOpts -> DistributeOpts -> DistributeOpts
semigroupDistributeOpts a b =
  DistributeOpts
    { distributeOptsAxis =
        firstUnlessDefault (\x -> x.distributeOptsAxis) a b,
      distributeOptsCount =
        firstUnlessDefault (\x -> x.distributeOptsCount) a b,
      distributeOptsFullLength =
        firstUnlessDefault (\x -> x.distributeOptsFullLength) a b,
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
