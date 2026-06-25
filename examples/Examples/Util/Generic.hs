{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE UndecidableInstances #-}

module Examples.Util.Generic where

import Data.Kind (Type)
import Data.Monoid (First (getFirst))
import GHC.Generics (C1, D1, Generic (Rep, from, to), K1 (..), M1 (..), Rec0, S1, (:*:) ((:*:)))

newtype SemigroupPlus a = SemigroupPlus a

instance (Generic a, Semi (Rep a), Monoid a) => Semigroup (SemigroupPlus a) where
  SemigroupPlus x <> SemigroupPlus y = SemigroupPlus $ gSemigroupPlus x y

gSemigroupPlus :: forall a. (Generic a, Semi (Rep a), Monoid a) => a -> a -> a
gSemigroupPlus x y = to (semi (from (mempty :: a)) (from x) (from y))

class Semi (f :: Type -> Type) where
  semi :: f p -> f p -> f p -> f p

instance (Semi f) => Semi (D1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (Semi f) => Semi (C1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (Semi f) => Semi (S1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (SemigroupPlusField a) => Semi (Rec0 a) where
  semi (K1 def) (K1 m1) (K1 m2) = K1 (semigroupPlusField def m1 m2)

instance (Semi f1, Semi f2) => Semi (f1 :*: f2) where
  semi (x1 :*: x2) (y1 :*: y2) (z1 :*: z2) = semi x1 y1 z1 :*: semi x2 y2 z2

class SemigroupPlusField a where
  semigroupPlusField :: a -> a -> a -> a

instance SemigroupPlusField Double where
  semigroupPlusField = firstUnlessDefault

instance SemigroupPlusField Int where
  semigroupPlusField = firstUnlessDefault

instance SemigroupPlusField (First a) where
  semigroupPlusField _ x y = x <> y

newtype FirstUnlessDefault a = FirstUnlessDefault a

firstUnlessDefault :: (Eq a) => a -> a -> a -> a
firstUnlessDefault def x y = if x == def then y else x
