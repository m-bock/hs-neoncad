{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

module NeonCAD (
  render2D, render3D,
  circleR, circleD,
  ellipseR, ellipseD,
  rect, rectCenter,
  square, squareCenter,
  polygon,
  union2D,
  moveXYZ, moveXY, moveXZ, moveYZ, moveX, moveY, moveZ,
  rotateZ,
  mirrorXY, mirrorX, mirrorY,
  colorRGB, colorRGBA, colorA,
  runNeonM, runNeonT,
  fn, fa, fs, defaultFacets,
  askFacets, localFacets,
  Model2D, Model3D, V2, V3, Facets,
  MonadNeon
) where

import OpenSCAD.Model
  ( Model2D(..), Primitive2D(..), Transform2D(..)
  , Model3D(..)
  , V2, V3
  , Facets(..)
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
-- Classes / Move
-------------------------------------------------------------------------------

class MoveX a m where
  moveX :: Double -> m a -> m a

class MoveY a m where
  moveY :: Double -> m a -> m a

class MoveZ a m where
  moveZ :: Double -> m a -> m a

class MoveXY a m where
  moveXY :: V2 Double -> m a -> m a

class MoveXZ a m where
  moveXZ :: V2 Double -> m a -> m a

class MoveYZ a m where
  moveYZ :: V2 Double -> m a -> m a

class MoveXYZ a m where
  moveXYZ :: V3 Double -> m a -> m a

class Resize a m where
  resize :: V2 ResizeOp -> m a -> m a

-------------------------------------------------------------------------------
-- Classes / Resize
-------------------------------------------------------------------------------

class ResizeXY a m where
  resizeXY :: V2 Double -> m a -> m a

class ResizeX a m where
  resizeX :: Double -> m a -> m a

class ResizeY a m where
  resizeY :: Double -> m a -> m a

class ResizeAutoX a m where
  resizeAutoX :: Double -> m a -> m a

class ResizeAutoY a m where
  resizeAutoY :: Double -> m a -> m a

-------------------------------------------------------------------------------
-- Classes / Rotate
-------------------------------------------------------------------------------

class RotateX a m where
  rotateX :: Double -> m a -> m a

class RotateY a m where
  rotateY :: Double -> m a -> m a

class RotateZ a m where
  rotateZ :: Double -> m a -> m a

--- ...

-------------------------------------------------------------------------------
-- Classes / Mirror
-------------------------------------------------------------------------------

class MirrorXY a m where
  mirrorXY :: V2 Double -> m a -> m a

class MirrorX a m where
  mirrorX :: m a -> m a

class MirrorY a m where
  mirrorY :: m a -> m a

-------------------------------------------------------------------------------
-- Classes / Color
-------------------------------------------------------------------------------

class Color a m where
  color :: Maybe (V3 Double) -> Maybe Double -> m a -> m a

class ColorRGB a m where
  colorRGB :: V3 Double -> m a -> m a

class ColorRGBA a m where
  colorRGBA :: V3 Double -> Double -> m a -> m a

class ColorA a m where
  colorA :: Double -> m a -> m a

--------------------------------------------------------
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
      pure $ Primitive2D Nothing (Circle2D {d = radialToDiameter size, _facets = Just facets})

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
  size :: V2 Radial
}

instance MonadNeon m => ToModel2D Ellipse m where
    toModel2D (Ellipse {size = (sizeX, sizeY)}) = do
      let diaX = radialToDiameter sizeX
          diaY = radialToDiameter sizeY
          diaMax = max diaX diaY 
      resizeXY (diaX, diaY) $ circleR diaMax

defaultEllipse :: Ellipse
defaultEllipse = Ellipse {
  size = (Diameter 100, Diameter 100)
}

ellipse :: MonadNeon m => V2 Radial -> m Model2D
ellipse size = toModel2D $ Ellipse { size = size }

ellipseR :: MonadNeon m => V2 Double -> m Model2D
ellipseR (rx, ry) = ellipse (Radius rx, Radius ry)

ellipseD :: MonadNeon m => V2 Double -> m Model2D
ellipseD (rx, ry) = ellipse (Diameter rx, Diameter ry)


-------------------------------------------------------------------------------
-- 2D / Rect
-------------------------------------------------------------------------------

data Rect = Rect {
  size :: V2 Double,
  center :: Bool
}

instance MonadNeon m => ToModel2D Rect m where
  toModel2D (Rect {size, center}) = pure $
    Primitive2D Nothing (Square2D {size = size, center = Just center})

defaultRect :: Rect
defaultRect = Rect {
  size = (100, 100),
  center = False
}

rect :: MonadNeon m => V2 Double -> m Model2D
rect size = toModel2D $ Rect { size = size, center = False }

rectCenter :: MonadNeon m => V2 Double -> m Model2D
rectCenter size = toModel2D $ Rect { size = size, center = True }

-------------------------------------------------------------------------------
-- 2D / Square
-------------------------------------------------------------------------------

data Square = Square {
  size :: Double,
  center :: Bool
}

instance MonadNeon m => ToModel2D Square m where
  toModel2D (Square {size, center}) = pure $
    Primitive2D Nothing (Square2D {size = (size, size), center = Just center})

defaultSquare :: Square
defaultSquare = Square {
  size = 100,
  center = False
}

square :: MonadNeon m => Double -> m Model2D
square size = toModel2D $ Square { size = size, center = False }

squareCenter :: MonadNeon m => Double -> m Model2D
squareCenter size = toModel2D $ Square { size = size, center = True }

-------------------------------------------------------------------------------
-- 2D / Polygon
-------------------------------------------------------------------------------

-- Paths are not supported yet, because they can be modeled with difference.
-- Maybe in the future paths can be added for ergonomics if needed.

data Polygon = Polygon {
  points :: [V2 Double],
  convexity :: Int
}

defaultPolygon :: Polygon
defaultPolygon = Polygon {
    points = [(0, 0), (100, 0), (100, 100), (0, 100)],
    convexity = defaultConvexity
}

defaultConvexity :: Int
defaultConvexity = 10

instance MonadNeon m => ToModel2D Polygon m where
  toModel2D (Polygon {points, convexity}) = pure $
    Primitive2D Nothing (Polygon2D {points = points, paths = Nothing, convexity = Just convexity})

polygon :: MonadNeon m => [V2 Double] -> m Model2D
polygon points = toModel2D $ Polygon { points = points, convexity = defaultConvexity }

-------------------------------------------------------------------------------
-- 2D / Scale
-------------------------------------------------------------------------------

scale2D :: V2 Double -> Model2D -> m Model2D
scale2D = undefined

-------------------------------------------------------------------------------
-- 2D / Resize
-------------------------------------------------------------------------------

data ResizeOp = Auto | Keep | Set Double

instance MonadNeon m => Resize Model2D m where
  resize (x, y) modelM = do
    model <- modelM
    let (valX, autoX) = getValueAndAuto x
        (valY, autoY) = getValueAndAuto y
    pure $ Transform2D Nothing (Resize2D
      { newSize = (valX,valY)
      , auto = Just (autoX, autoY)
      }) [model]

getValueAndAuto :: ResizeOp -> (Double, Bool)
getValueAndAuto op = case op of
  Auto -> (0, True)
  Keep -> (0, False)
  Set d -> (d, False)

instance MonadNeon m => ResizeXY Model2D m where
  resizeXY (x, y) modelM = resize (Set x, Set y) modelM

instance MonadNeon m => ResizeX Model2D m where
  resizeX x modelM = resize (Set x, Keep) modelM

instance MonadNeon m => ResizeY Model2D m where
  resizeY y modelM = resize (Keep, Set y) modelM

instance MonadNeon m => ResizeAutoX Model2D m where
  resizeAutoX val modelM = resize (Set val, Auto) modelM

instance MonadNeon m => ResizeAutoY Model2D m where
  resizeAutoY val modelM = resize (Auto, Set val) modelM

-------------------------------------------------------------------------------
-- 2D / Rotate
-------------------------------------------------------------------------------

instance MonadNeon m => RotateZ Model2D m where
  rotateZ angle modelM = do
    model <- modelM
    pure $ Transform2D Nothing (RotateAxis2D {a = angle, mv2 = Nothing}) [model]

-------------------------------------------------------------------------------
-- 2D / Move
-------------------------------------------------------------------------------

instance MonadNeon m => MoveXYZ Model2D m where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform2D Nothing (Translate2D v) [model]

instance MonadNeon m => MoveXY Model2D m where
  moveXY (x, y) modelsM = moveXYZ (x, y, 0) modelsM

instance MonadNeon m => MoveXZ Model2D m where
  moveXZ (x, z) modelsM = moveXYZ (x, 0, z) modelsM

instance MonadNeon m => MoveYZ Model2D m where
  moveYZ (y, z) modelsM = moveXYZ (0, y, z) modelsM

instance MonadNeon m => MoveX Model2D m where
  moveX x modelsM = moveXYZ (x, 0, 0) modelsM

instance MonadNeon m => MoveY Model2D m where
  moveY y modelsM = moveXYZ (0, y, 0) modelsM

instance MonadNeon m => MoveZ Model2D m where
  moveZ z modelsM = moveXYZ (0, 0, z) modelsM

-------------------------------------------------------------------------------
-- 2D / Mirror
-------------------------------------------------------------------------------

instance MonadNeon m => MirrorXY Model2D m where
  mirrorXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D Nothing (Mirror2D {v2 = (x, y)}) [model]

instance MonadNeon m => MirrorX Model2D m where
  mirrorX modelM = mirrorXY (1, 0) modelM

instance MonadNeon m => MirrorY Model2D m where
  mirrorY modelM = mirrorXY (0, 1) modelM

-------------------------------------------------------------------------------
-- 2D / Color
-------------------------------------------------------------------------------

instance MonadNeon m => Color Model2D m where
  color c a modelM = do
    model <- modelM
    pure $ Transform2D Nothing (Color2D {c = c, alpha = a}) [model]

instance MonadNeon m => ColorRGB Model2D m where
  colorRGB c modelM = color (Just c) Nothing modelM

instance MonadNeon m => ColorRGBA Model2D m where
  colorRGBA c a modelM = color (Just c) (Just a) modelM

instance MonadNeon m => ColorA Model2D m where
  colorA a modelM = color Nothing (Just a) modelM

-------------------------------------------------------------------------------
-- ...
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 2D / Union
-------------------------------------------------------------------------------

union2D :: (MonadNeon m) => [m Model2D] -> m Model2D
union2D modelsM = do
  models <- sequence modelsM
  pure $ Transform2D Nothing Union2D models

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
