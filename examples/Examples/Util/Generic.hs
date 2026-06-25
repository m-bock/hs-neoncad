{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE UndecidableInstances #-}

module Examples.Util.Generic where

import Data.Kind (Type)
import GHC.Generics (C1, D1, Generic (Rep, from, to), K1 (..), M1 (..), Rec0, S1, (:*:) ((:*:)))

newtype FirstUnlessDefault a = FirstUnlessDefault a

instance (Generic a, Semi (Rep a), Monoid a) => Semigroup (FirstUnlessDefault a) where
  FirstUnlessDefault x <> FirstUnlessDefault y = FirstUnlessDefault $ genericSemigroupFirstUnlessDefault x y

genericSemigroupFirstUnlessDefault :: forall a. (Generic a, Semi (Rep a), Monoid a) => a -> a -> a
genericSemigroupFirstUnlessDefault x y = to (semi (from (mempty :: a)) (from x) (from y))

class Semi (f :: Type -> Type) where
  semi :: f p -> f p -> f p -> f p

instance (Semi f) => Semi (D1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (Semi f) => Semi (C1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (Semi f) => Semi (S1 x f) where
  semi (M1 def) (M1 m1) (M1 m2) = M1 (semi @f def m1 m2)

instance (Eq a) => Semi (Rec0 a) where
  semi (K1 def) (K1 m1) (K1 m2) = K1 (if m1 == def then m2 else m1)

instance (Semi f1, Semi f2) => Semi (f1 :*: f2) where
  semi (x1 :*: x2) (y1 :*: y2) (z1 :*: z2) = semi x1 y1 z1 :*: semi x2 y2 z2
