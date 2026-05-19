module NeonCAD (
  render2D, render3D,
  circleR,
  runNeonM, runNeonT,
  fn, fa, fs, defaultFacets,
) where

import OpenSCAD.Model
  ( Model2D(..), Primitive2D(..), Facets(..), Model3D(..), V2, V3
  , render2D, render3D
  )
import Data.Functor.Identity (Identity (runIdentity))

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

data Radial = Radius Double | Diameter Double

newtype Convexity = Convexity Int

-------------------------------------------------------------------------------
-- Classes
-------------------------------------------------------------------------------

class (Monad m) => MonadNeon m where
  askFacets :: m Facets
  localFacets :: Facets -> m a -> m a

class ToModel2D a m where
    toModel2D :: a -> m Model2D

-------------------------------------------------------------------------------
-- Monad
-------------------------------------------------------------------------------

newtype NeonT m a = NeonT (Facets -> m a)
  deriving (Functor)

type NeonM = NeonT Identity

runNeonT :: Facets -> NeonT m a -> m a
runNeonT factes (NeonT f) = f factes

runNeonM :: Facets -> NeonM a -> a
runNeonM facets neon = runIdentity $ runNeonT facets neon

instance (Monad m) => Applicative (NeonT m) where
  pure x = NeonT $ \_ -> pure x
  f <*> v = NeonT $ \ r -> runNeonT r f <*> runNeonT r v

instance (Monad m) => Monad (NeonT m) where
  return = pure
  a >>= f = NeonT $ \ r -> runNeonT r a >>= \b -> runNeonT r (f b)

instance Monad m => MonadNeon (NeonT m) where
  askFacets = NeonT pure
  localFacets facets m = NeonT $ \_ -> runNeonT facets m

-------------------------------------------------------------------------------
-- Factes
-------------------------------------------------------------------------------

-- Usage e.g.: `fn 10 <> fa 0.1 <> fs 0.1`

fn :: Int -> Facets
fn i = mempty { fn = Just i }

fa :: Double -> Facets
fa d = mempty { fa = Just d }

fs :: Double -> Facets
fs d = mempty { fs = Just d }

defaultFacets :: Facets
defaultFacets = Facets
  { fn = Nothing
  , fa = Just 6
  , fs = Just 0.5
  }

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------

radialToDiameter :: Radial -> Double
radialToDiameter (Radius r) = r * 2
radialToDiameter (Diameter d) = d

-------------------------------------------------------------------------------
-- 2D / Circle
-------------------------------------------------------------------------------

data Circle = Circle {
  size :: Radial
}

instance MonadNeon m => ToModel2D Circle m where
    toModel2D (Circle {size}) = do
      facets <- askFacets
      pure $ Primitive2D (Circle2D {d = radialToDiameter size, _facets = Just facets})

defaultCircle :: Circle
defaultCircle = Circle {
  size = Diameter 100
}

circle :: MonadNeon m => Radial -> m Model2D
circle r = toModel2D $ Circle { size = r }

circleR :: MonadNeon m => Double -> m Model2D
circleR r = circle (Radius r)

circleD :: MonadNeon m => Double -> m Model2D
circleD d = circle (Diameter d)

-------------------------------------------------------------------------------
-- 2D / Ellipse
-------------------------------------------------------------------------------

data Ellipse = Ellipse {
  sizeX :: Radial,
  sizeY :: Radial,
  facets :: Maybe Facets
}

instance ToModel2D Ellipse m where
    toModel2D = undefined

defaultEllipse :: Ellipse
defaultEllipse = Ellipse {
  sizeX = Diameter 100,
  sizeY = Diameter 100,
  facets = Nothing
}

ellipse :: V2 Radial -> m Model2D
ellipse = undefined

ellipse' :: V2 Radial -> Facets -> m Model2D
ellipse' = undefined

ellipseR :: V2 Double -> m Model2D
ellipseR = undefined

ellipseD :: V2 Double -> m Model2D
ellipseD = undefined

ellipseR' :: V2 Double -> Facets -> m Model2D
ellipseR' = undefined

ellipseD' :: V2 Double -> Facets -> m Model2D
ellipseD' = undefined

-------------------------------------------------------------------------------
-- 2D / Rect
-------------------------------------------------------------------------------

data Rect = Rect {
  size :: V2 Double,
  center :: Bool
}

instance ToModel2D Rect m where
  toModel2D = undefined

defaultRect :: Rect
defaultRect = Rect {
  size = (100, 100),
  center = False
}

rect :: V2 Double -> m Model2D
rect = undefined

rectCenter :: V2 Double -> m Model2D
rectCenter = undefined

-------------------------------------------------------------------------------
-- 2D / Square
-------------------------------------------------------------------------------

data Square = Square {
  size :: Double,
  center :: Bool
}

instance ToModel2D Square m where
  toModel2D = undefined

defaultSquare :: Square
defaultSquare = Square {
  size = 100,
  center = False
}

square :: Double -> m Model2D
square = undefined

squareCenter :: Double -> m Model2D
squareCenter = undefined

-------------------------------------------------------------------------------
-- 2D / Polygon
-------------------------------------------------------------------------------

data Polygon = Polygon {
  points :: [V2 Double],
  paths :: Maybe [[Int]],
  convexity :: Maybe Int
}

instance ToModel2D Polygon m where
  toModel2D = undefined

defaultPolygon :: Polygon
defaultPolygon = Polygon {
    points = [(0, 0), (100, 0), (100, 100), (0, 100)],
    paths = Nothing,
    convexity = Nothing
}

polygon :: [V2 Double] -> m Model2D
polygon = undefined

polygon' :: [V2 Double] -> Convexity -> m Model2D
polygon' = undefined

polygonWithPaths :: [V2 Double] -> [[Int]] -> m Model2D
polygonWithPaths = undefined

polygonWithPaths' :: [V2 Double] -> [[Int]] -> Convexity -> m Model2D
polygonWithPaths' = undefined

-------------------------------------------------------------------------------
-- 2D / Scale
-------------------------------------------------------------------------------

scale2D :: V2 Double -> Model2D -> m Model2D
scale2D = undefined

-------------------------------------------------------------------------------
-- 2D / Resize
-------------------------------------------------------------------------------

data ResizeSpec2D = ResizeSpec2D {
  size :: V2 Double,
  auto :: V2 Bool
}

resizeBySpec2D :: ResizeSpec2D -> Model2D -> m Model2D
resizeBySpec2D = undefined

resize2D :: V2 Double -> m Model2D
resize2D = undefined

resizeAuto2D :: V2 (Maybe Double) -> m Model2D
resizeAuto2D = undefined


-------------------------------------------------------------------------------
-- 2D / RotateEuler
-------------------------------------------------------------------------------

-- rotateX, rotateY, rotateXY

rotateEuler2D :: V2 Double -> m Model2D
rotateEuler2D = undefined

newtype Degree = Degree Double

data RotateAxis2D = RotateAxis2D {
  angle :: Degree,
  pivot :: V2 Double
}

rotateAxisBy2D :: RotateAxis2D -> m Model2D
rotateAxisBy2D = undefined

rotateAxis2D :: Degree -> V2 Double -> m Model2D
rotateAxis2D = undefined



-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------

data Projection = Projection {
  cut :: Maybe Bool
}

-- mkProjection :: Projection -> m Model2D
-- mkProjection = undefined

-- projection :: [m Model3D] -> m Model2D
-- projection = undefined

-- projectionCut :: [m Model3D] -> m Model2D
-- projectionCut = undefined


-------------------------------------------------------------------------------
-- Resize3D
-------------------------------------------------------------------------------

data Resize3D = Resize3D {
  size :: V3 Double,
  auto :: V3 Bool
}

resizeBy3D :: Resize3D -> Model3D -> m Model3D
resizeBy3D = undefined

resize3D :: V3 Double -> m Model3D
resize3D = undefined

resizeAuto3D :: V3 (Maybe Double) -> m Model3D
resizeAuto3D = undefined



-------------------------------------------------------------------------------
-- Scale3D
-------------------------------------------------------------------------------

scale3D :: V3 Double -> Model3D -> m Model3D
scale3D = undefined


-------------------------------------------------------------------------------
-- S
-------------------------------------------------------------------------------

someFunc :: IO ()
someFunc = putStrLn "someFunc"
