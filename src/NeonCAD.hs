{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving, DeriveFunctor #-}
{-# LANGUAGE RankNTypes #-}

module NeonCAD (
  comment,
  render2D, render3D,

  diameter, radius,
  facets,
  center, corner,
  scale,
  size,
  HasSize, HasPlacement,
  height,
  centerZ,

  -- 2D / Primitive
  ellipse,
  circle,
  rect,
  square,
  polygon, points, convexity,
  text, str, TextOpts, FontName, FontStyle, fontName, fontStyle, fontSize, direction, hAlign, vAlign, fontSpacing,

  offset, offsetRound, offsetCut,

  -- 3D / Primitive
  box,
  cube,
  sphere,
  ellipsoid,
  cylinder,

  empty,

  -- Transform
  union, unions,
  intersection, intersections,
  difference,
  resizeXYZ, resizeXY, resizeXZ, resizeYZ, resizeX, resizeY, resizeZ,
  resizeAutoXY, resizeAutoXZ, resizeAutoYZ, resizeAutoX, resizeAutoY, resizeAutoZ,
  moveXYZ, moveXY, moveXZ, moveYZ, moveX, moveY, moveZ,
  spinXYZ, spinXY, spinXZ, spinYZ, spinX, spinY, spinZ,
  mirrorXYZ, mirrorXY, mirrorXZ, mirrorYZ, mirrorX, mirrorY, mirrorZ,
  color, rgb, alpha, Color,
  hull,

  -- 2D-3D Conversion
  extrudeLinear, extrudeRotational,

  -- Modifiers
  modDisable, modShowOnly, modHighlight, modTransparent,

  runNeonM, runNeonT,
  fn, fa, fs, defaultFacets,
  askFacets, localFacets,
  Model2D, Model3D, V2, V3, Facets,
  MonadNeon
) where

-------------------------------------------------------------------------------
-- / Imports
-------------------------------------------------------------------------------

import qualified OpenSCAD

import OpenSCAD
  ( Model2D(..), Primitive2D(..), Transform2D(..)
  , Model3D(..), Primitive3D(..), Transform3D(..)
  , Direction(..), HorizontalAlignment(..), VerticalAlignment(..)
  , Modifier(..)
  , Extrude3D(..)
  , BoolOp2D(..), BoolOp3D(..)
  , V2, V3
  , Facets(..)
  , Font(..)
  )

import Data.Functor.Identity (Identity (runIdentity))
import Data.Monoid (First(..))
import Data.Maybe (fromMaybe)
import GHC.Generics
import Barbies

-------------------------------------------------------------------------------
-- / Defaults
-------------------------------------------------------------------------------

defaultFacets :: Facets
defaultFacets = Facets
  { fn = Nothing
  , fa = Just 6
  , fs = Just 0.5
  }

defaultConvexity :: Int
defaultConvexity = 10

-- * 1D

defaultLength :: Double
defaultLength = 100

defaultRatio :: Double
defaultRatio = 1.6

-- * 2D

defaultArea :: Double
defaultArea = 
  defaultLength * defaultLength

defaultCircleRadius :: Double
defaultCircleRadius = sqrt (defaultArea / pi)


defaultCircleDiameter :: Double
defaultCircleDiameter = defaultCircleRadius * 2

defaultEllipseSize :: V2 Double
defaultEllipseSize = 
  ( 2 * sqrt (defaultArea * defaultRatio / pi)
  , 2 * sqrt (defaultArea / (defaultRatio * pi))
  )

defaultRectSize :: V2 Double
defaultRectSize =
  ( sqrt (defaultArea * defaultRatio)
  , sqrt (defaultArea / defaultRatio)
  )

defaultSquareSize :: Double
defaultSquareSize = sqrt defaultArea

defaultPolygonPoints :: [V2 Double]
defaultPolygonPoints = scalePolygonToArea defaultArea
  [ (-50, -50)
  , (-10, -40)
  , ( 30, -50)
  , ( 50, -10)
  , ( 10,   0)
  , ( 50,  50)
  , (-40,  30)
  ] 

scalePolygonToArea :: Double -> [V2 Double] -> [V2 Double]
scalePolygonToArea targetArea ps =
  map scalePoint ps
  where
    currentArea = polygonArea ps
    s = sqrt (targetArea / currentArea)

    scalePoint (x, y) = (x * s, y * s)

polygonArea :: [V2 Double] -> Double
polygonArea ps =
  abs (sum (zipWith cross ps (tail (cycle ps)))) / 2
  where
    cross (x1, y1) (x2, y2) = x1 * y2 - y1 * x2

-- * 3D

defaultVolume :: Double
defaultVolume = defaultArea * defaultLength

defaultBoxSize :: V3 Double
defaultBoxSize =
  ( defaultVolume ** (1/3) * defaultRatio ** (2/3)
  , defaultVolume ** (1/3) /  defaultRatio ** (1/3)
  , defaultVolume ** (1/3) /  defaultRatio ** (1/3)
  )

defaultCubeSize :: Double
defaultCubeSize = defaultVolume ** (1/3)

defaultSphereRadius :: Double
defaultSphereRadius =
  ((3 * defaultVolume) / (4 * pi)) ** (1 / 3)

defaultSphereDiameter :: Double
defaultSphereDiameter =
  2 * defaultSphereRadius

defaultEllipsoidSize :: V3 Double
defaultEllipsoidSize =
  let b = ((3 * defaultVolume) / (4 * pi * defaultRatio)) ** (1 / 3)
      a = defaultRatio * b
  in
    (2 * a, 2 * b, 2 * b)


defaultCylinderRadius :: Double
defaultCylinderRadius = (defaultVolume / defaultRatio / pi) ** (1/3)

defaultCylinderDiameter :: Double
defaultCylinderDiameter = 2 * defaultCylinderRadius

defaultCylinderHeight :: Double
defaultCylinderHeight = defaultCylinderRadius * defaultRatio 

-------------------------------------------------------------------------------
-- / Monad
-------------------------------------------------------------------------------

newtype NeonT m a = NeonT (Facets -> m a)
  deriving (Functor)

type NeonM = NeonT Identity

runNeonT :: Facets -> NeonT m a -> m a
runNeonT factes (NeonT f) = f factes

runNeonM :: Facets -> NeonM a -> a
runNeonM facets neon = get $ runNeonT facets neon

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
-- / Facets
-------------------------------------------------------------------------------

-- Usage e.g.: `fn 10 <> fa 0.1 <> fs 0.1`

fn :: Int -> Facets
fn i = mempty { fn = Just i }

fa :: Double -> Facets
fa d = mempty { fa = Just d }

fs :: Double -> Facets
fs d = mempty { fs = Just d }

-------------------------------------------------------------------------------
-- / Classes
-------------------------------------------------------------------------------

class (Monad m) => MonadNeon m where
  askFacets :: m Facets
  localFacets :: Facets -> m a -> m a

-------------------------------------------------------------------------------
-- / Classes / HasPlacement
-------------------------------------------------------------------------------

data Placement = PlacementCenter | PlacementCorner

class HasPlacement a where
  placement :: Placement -> a

center :: HasPlacement a => a
center = placement PlacementCenter

corner :: HasPlacement a => a
corner = placement PlacementCorner

-------------------------------------------------------------------------------
-- / Classes / HasDiameter
-------------------------------------------------------------------------------

class HasDiameter a where
  diameter :: Double -> a

radius :: HasDiameter a => Double -> a
radius r = diameter (r * 2)

-------------------------------------------------------------------------------
-- / Classes / HasFacets
-------------------------------------------------------------------------------

class HasFacets a where
  facets :: Facets -> a

-------------------------------------------------------------------------------
-- / Classes / HasSize
-------------------------------------------------------------------------------

class HasSize v a | a -> v where
  size :: v -> a

-------------------------------------------------------------------------------
-- / Classes / Comment
-------------------------------------------------------------------------------

class Comment a where
  comment :: String -> a -> a

instance MonadNeon m => Comment (m Model2D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment2D txt model

instance MonadNeon m => Comment (m Model3D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment3D txt model

-------------------------------------------------------------------------------
-- / Classes / Scale
-------------------------------------------------------------------------------

class ScaleXYZ a where
  scaleXYZ :: V3 Double -> a -> a

class ScaleXY a where
  scaleXY :: V2 Double -> a -> a

class ScaleXZ a where
  scaleXZ :: V2 Double -> a -> a

class ScaleYZ a where
  scaleYZ :: V2 Double -> a -> a

class ScaleX a where
  scaleX :: Double -> a -> a

class ScaleY a where
  scaleY :: Double -> a -> a

class ScaleZ a where
  scaleZ :: Double -> a -> a

class Scale a where
  scale :: Double -> a -> a

-- * 2D

instance (MonadNeon m) => ScaleXY (m Model2D) where
  scaleXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Scale2D (x, y)) [model]

instance (MonadNeon m) => ScaleX (m Model2D) where
  scaleX x modelM = scaleXY (x, 1) modelM

instance (MonadNeon m) => ScaleY (m Model2D) where
  scaleY y modelM = scaleXY (1, y) modelM

instance MonadNeon m => Scale (m Model2D) where
  scale x modelM = scaleXY (x, x) modelM

-- * 3D

instance (MonadNeon m) => ScaleXYZ (m Model3D) where
  scaleXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Scale3D v) [model]

instance (MonadNeon m) => ScaleXY (m Model3D) where
  scaleXY (x, y) modelM = scaleXYZ (x, y, 1) modelM
  
instance (MonadNeon m) => ScaleXZ (m Model3D) where
  scaleXZ (x, z) modelM = scaleXYZ (x, 1, z) modelM

instance (MonadNeon m) => ScaleYZ (m Model3D) where
  scaleYZ (y, z) modelM = scaleXYZ (1, y, z) modelM

instance (MonadNeon m) => ScaleX (m Model3D) where
  scaleX x modelM = scaleXYZ (x, 1, 1) modelM

instance (MonadNeon m) => ScaleY (m Model3D) where
  scaleY y modelM = scaleXYZ (1, y, 1) modelM

instance MonadNeon m => Scale (m Model3D) where
  scale x modelM = scaleXYZ (x, x, x) modelM

-------------------------------------------------------------------------------
-- / Classes / Move
-------------------------------------------------------------------------------

class MoveXYZ a where
  moveXYZ :: V3 Double -> a -> a

class MoveXY a where
  moveXY :: V2 Double -> a -> a

class MoveXZ a where
  moveXZ :: V2 Double -> a -> a

class MoveYZ a where
  moveYZ :: V2 Double -> a -> a

class MoveX a where
  moveX :: Double -> a -> a

class MoveY a where
  moveY :: Double -> a -> a

class MoveZ a where
  moveZ :: Double -> a -> a

-- * 2D

instance (MonadNeon m) => MoveXY (m Model2D) where
  moveXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (x, y, 0)) [model]

instance (MonadNeon m) => MoveX (m Model2D) where
  moveX x modelM = moveXY (x, 0) modelM

instance (MonadNeon m) => MoveY (m Model2D) where
  moveY y modelM = moveXY (0, y) modelM

instance (MonadNeon m) => MoveZ (m Model2D) where
  moveZ z modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (0, 0, z)) [model]


-- * 3D

instance (MonadNeon m) => MoveXYZ (m Model3D) where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Translate3D v) [model]

instance (MonadNeon m) => MoveXY (m Model3D) where
  moveXY (x, y) modelM = moveXYZ (x, y, 0) modelM

instance (MonadNeon m) => MoveXZ (m Model3D) where
  moveXZ (x, z) modelM = moveXYZ (x, 0, z) modelM

instance (MonadNeon m) => MoveYZ (m Model3D) where
  moveYZ (y, z) modelM = moveXYZ (0, y, z) modelM

instance (MonadNeon m) => MoveX (m Model3D) where
  moveX x modelM = moveXYZ (x, 0, 0) modelM

instance (MonadNeon m) => MoveY (m Model3D) where
  moveY y modelM = moveXYZ (0, y, 0) modelM

instance (MonadNeon m) => MoveZ (m Model3D) where
  moveZ z modelM = moveXYZ (0, 0, z) modelM


-------------------------------------------------------------------------------
-- / Classes / Resize
-------------------------------------------------------------------------------

class ResizeXYZ a where
  resizeXYZ :: V3 Double -> a -> a

class ResizeXY a where
  resizeXY :: V2 Double -> a -> a

class ResizeXZ a where
  resizeXZ :: V2 Double -> a -> a

class ResizeYZ a where
  resizeYZ :: V2 Double -> a -> a

class ResizeX a where
  resizeX :: Double -> a -> a

class ResizeY a where
  resizeY :: Double -> a -> a

class ResizeZ a where
  resizeZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => ResizeXY (m Model2D) where
  resizeXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, y) Nothing) [model]
    
    
instance (MonadNeon m) => ResizeX (m Model2D) where
  resizeX x modelM = resizeXY (x, 1) modelM

instance (MonadNeon m) => ResizeY (m Model2D) where
  resizeY y modelM = resizeXY (1, y) modelM


-- * 3D

instance (MonadNeon m) => ResizeXYZ (m Model3D) where
  resizeXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, z) Nothing) [model]
    
instance (MonadNeon m) => ResizeXY (m Model3D) where
  resizeXY (x, y) modelM = resizeXYZ (x, y, 0) modelM
  
instance (MonadNeon m) => ResizeXZ (m Model3D) where
  resizeXZ (x, z) modelM = resizeXYZ (x, 1, z) modelM

instance (MonadNeon m) => ResizeYZ (m Model3D) where
  resizeYZ (y, z) modelM = resizeXYZ (1, y, z) modelM

instance (MonadNeon m) => ResizeX (m Model3D) where
  resizeX x modelM = resizeXYZ (x, 1, 1) modelM

instance (MonadNeon m) => ResizeY (m Model3D) where
  resizeY y modelM = resizeXYZ (1, y, 1) modelM

instance (MonadNeon m) => ResizeZ (m Model3D) where
  resizeZ z modelM = resizeXYZ (1, 1, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Resize Auto
-------------------------------------------------------------------------------

class ResizeAutoXY a where
  resizeAutoXY :: V2 Double -> a -> a

class ResizeAutoXZ a where
  resizeAutoXZ :: V2 Double -> a -> a

class ResizeAutoYZ a where
  resizeAutoYZ :: V2 Double -> a -> a

class ResizeAutoX a where
  resizeAutoX :: Double -> a -> a

class ResizeAutoY a where
  resizeAutoY :: Double -> a -> a

class ResizeAutoZ a where
  resizeAutoZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => ResizeAutoX (m Model2D) where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, 0) (Just (False, True))) [model]

instance (MonadNeon m) => ResizeAutoY (m Model2D) where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (0, y) (Just (True, False))) [model]


-- * 3D

instance (MonadNeon m) => ResizeAutoXY (m Model3D) where
  resizeAutoXY (x, y) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, 0) (Just (False, False, True))) [model]
  
instance (MonadNeon m) => ResizeAutoXZ (m Model3D) where
  resizeAutoXZ (x, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, z) (Just (False, True, False))) [model]
  
instance (MonadNeon m) => ResizeAutoYZ (m Model3D) where
  resizeAutoYZ (y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, z) (Just (True, False, False))) [model]

instance (MonadNeon m) => ResizeAutoX (m Model3D) where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, 0) (Just (False, True, True))) [model]

instance (MonadNeon m) => ResizeAutoY (m Model3D) where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, 0) (Just (True, False, True))) [model]

instance (MonadNeon m) => ResizeAutoZ (m Model3D) where
  resizeAutoZ z modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, 0, z) (Just (True, True, False))) [model]


-------------------------------------------------------------------------------
-- / Classes / Spin
-------------------------------------------------------------------------------

class SpinXYZ a where
  spinXYZ :: V3 Double -> a -> a

class SpinXY a where
  spinXY :: V2 Double -> a -> a

class SpinXZ a where
  spinXZ :: V2 Double -> a -> a

class SpinYZ a where
  spinYZ :: V2 Double -> a -> a

class SpinX a where
  spinX :: Double -> a -> a

class SpinY a where
  spinY :: Double -> a -> a

class SpinZ a where
  spinZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => SpinZ (m Model2D) where
  spinZ z modelM = do
    model <- modelM
    pure $ Transform2D (RotateEuler2D (0, 0, z)) [model]


-- * 3D

instance (MonadNeon m) => SpinXYZ (m Model3D) where
  spinXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (RotateEuler3D (x, y, z)) [model]

instance (MonadNeon m) => SpinXY (m Model3D) where
  spinXY (x, y) modelM = spinXYZ (x, y, 0) modelM

instance (MonadNeon m) => SpinXZ (m Model3D) where
  spinXZ (x, z) modelM = spinXYZ (x, 0, z) modelM

instance (MonadNeon m) => SpinYZ (m Model3D) where
  spinYZ (y, z) modelM = spinXYZ (0, y, z) modelM

instance (MonadNeon m) => SpinX (m Model3D) where
  spinX x modelM = spinXYZ (x, 0, 0) modelM

instance (MonadNeon m) => SpinY (m Model3D) where
  spinY y modelM = spinXYZ (0, y, 0) modelM

instance (MonadNeon m) => SpinZ (m Model3D) where
  spinZ z modelM = spinXYZ (0, 0, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Mirror
-------------------------------------------------------------------------------

class MirrorXYZ a where
  mirrorXYZ :: V3 Double -> a -> a

class MirrorXY a where
  mirrorXY :: V2 Double -> a -> a

class MirrorXZ a where
  mirrorXZ :: V2 Double -> a -> a

class MirrorYZ a where
  mirrorYZ :: V2 Double -> a -> a

class MirrorX a where
  mirrorX :: a -> a

class MirrorY a where
  mirrorY :: a -> a

class MirrorZ a where
  mirrorZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => MirrorX (m Model2D) where
  mirrorX modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (0, 1)) [model]


instance (MonadNeon m) => MirrorY (m Model2D) where
  mirrorY modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (1, 0)) [model]

instance (MonadNeon m) => MirrorXY (m Model2D) where
  mirrorXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (x, y)) [model]

-- * 3D

instance (MonadNeon m) => MirrorXYZ (m Model3D) where
  mirrorXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Mirror3D (x, y, z)) [model]

instance (MonadNeon m) => MirrorXY (m Model3D) where
  mirrorXY (x, y) modelM = mirrorXYZ (x, y, 0) modelM

instance (MonadNeon m) => MirrorXZ (m Model3D) where
  mirrorXZ (x, z) modelM = mirrorXYZ (x, 0, z) modelM

instance (MonadNeon m) => MirrorYZ (m Model3D) where
  mirrorYZ (y, z) modelM = mirrorXYZ (0, y, z) modelM

instance (MonadNeon m) => MirrorX (m Model3D) where
  mirrorX modelM = mirrorXYZ (1, 0, 0) modelM

instance (MonadNeon m) => MirrorY (m Model3D) where
  mirrorY modelM = mirrorXYZ (0, 1, 0) modelM

instance (MonadNeon m) => MirrorZ (m Model3D) where
  mirrorZ z modelM = mirrorXYZ (0, 0, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Color
-------------------------------------------------------------------------------

data ColorOpts f = ColorOpts {
  colorOptsRgb :: f (V3 Double),
  colorOptsAlpha :: f Double
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (ColorOpts First)
  instance Semigroup (ColorOpts First)

deriving via Generically (ColorOpts First)
  instance Monoid (ColorOpts First)

fallbackColorOpts :: ColorOpts Identity
fallbackColorOpts = ColorOpts {
  colorOptsRgb = pure (0, 0, 0),
  colorOptsAlpha = pure 1
}

class Color a where
  color :: ColorOpts First -> a -> a

rgb :: V3 Double -> ColorOpts First
rgb rgbValues = mempty { colorOptsRgb = First $ Just rgbValues }

alpha :: Double -> ColorOpts First
alpha alphaValue = mempty { colorOptsAlpha = First $ Just alphaValue }

-- * 2D

instance (MonadNeon m) => Color (m Model2D) where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform2D (Color2D (get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts :: ColorOpts Identity
      opts = bzipWith orDef fallbackColorOpts optsMay

-- * 3D

instance (MonadNeon m) => Color (m Model3D) where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform3D (Color3D (get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts :: ColorOpts Identity
      opts = bzipWith orDef fallbackColorOpts optsMay

-------------------------------------------------------------------------------
-- / Classes / Hull
-------------------------------------------------------------------------------

class Hull a where
  hull :: a -> a

-- * 2D

instance (MonadNeon m) => Hull (m Model2D) where
  hull modelM = do
    model <- modelM
    pure $ Transform2D Hull2D [model]


-- * 3D

instance (MonadNeon m) => Hull (m Model3D) where
  hull modelM = do
    model <- modelM
    pure $ Transform3D Hull3D [model]

-------------------------------------------------------------------------------
-- / Classes / Union
-------------------------------------------------------------------------------

class Union a where
  union :: a -> a -> a
  unions :: [a] -> a


-- * 2D

instance (MonadNeon m) => Union (m Model2D) where
  union modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Union2D [modelA, modelB]

  unions modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Union2D models


-- * 3D

instance (MonadNeon m) => Union (m Model3D) where
  union modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Union3D [modelA, modelB]

  unions modelsM = do
    models <- sequence modelsM
    pure $ BoolOp3D Union3D models

-------------------------------------------------------------------------------
-- / Classes / Empty
-------------------------------------------------------------------------------

class Empty a where
  empty :: a


-- * 2D

instance (MonadNeon m) => Empty (m Model2D) where
  empty = pure $ BoolOp2D Union2D []


-- * 3D

instance (MonadNeon m) => Empty (m Model3D) where
  empty = pure $ BoolOp3D Union3D []

-------------------------------------------------------------------------------
-- / Classes / Intersection
-------------------------------------------------------------------------------

class Intersection a where
  intersection :: a -> a -> a
  intersections :: [a] -> a


-- * 2D

instance (MonadNeon m) => Intersection (m Model2D) where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Intersection2D [modelA, modelB]

  intersections modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Intersection2D models


-- * 3D

instance (MonadNeon m) => Intersection (m Model3D) where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Intersection3D [modelA, modelB]

-------------------------------------------------------------------------------
-- / Classes / Difference
-------------------------------------------------------------------------------

class Difference a where
  difference :: a -> a -> a


-- * 2D

instance (MonadNeon m) => Difference (m Model2D) where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Difference2D [modelA, modelB]


-- * 3D

instance (MonadNeon m) => Difference (m Model3D) where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Difference3D [modelA, modelB]

-------------------------------------------------------------------------------
-- / Classes / Modifiers
-------------------------------------------------------------------------------

class Modifiers a where
  modDisable :: a -> a
  modShowOnly :: a -> a
  modHighlight :: a -> a
  modTransparent :: a -> a


-- * 2D

instance (MonadNeon m) => Modifiers (m Model2D) where
  modDisable modelM = do
    model <- modelM
    pure $ Modifier2D ModDisable model
  modShowOnly modelM = do
    model <- modelM
    pure $ Modifier2D ModShowOnly model
  modHighlight modelM = do
    model <- modelM
    pure $ Modifier2D ModHighlight model
  modTransparent modelM = do
    model <- modelM
    pure $ Modifier2D ModTransparent model


-- * 3D

instance (MonadNeon m) => Modifiers (m Model3D) where
  modDisable modelM = do
    model <- modelM
    pure $ Modifier3D ModDisable model
  modShowOnly modelM = do
    model <- modelM
    pure $ Modifier3D ModShowOnly model
  modHighlight modelM = do
    model <- modelM
    pure $ Modifier3D ModHighlight model
  modTransparent modelM = do
    model <- modelM
    pure $ Modifier3D ModTransparent model

-------------------------------------------------------------------------------
-- / 2D / Primitive / Circle
-------------------------------------------------------------------------------

data CircleOpts f = CircleOpts {
  circleOptsDiameter  :: f Double,
  circleOptsPlacement :: f Placement,
  circleOptsFacets    :: f Facets
} deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (CircleOpts First)
  instance Semigroup (CircleOpts First)

deriving via Generically (CircleOpts First)
  instance Monoid (CircleOpts First)

fallbackCircleOpts :: Facets -> CircleOpts Identity
fallbackCircleOpts fc = CircleOpts {
    circleOptsDiameter  = pure defaultCircleDiameter,
    circleOptsPlacement = pure PlacementCenter,
    circleOptsFacets    = pure fc
  }

instance HasDiameter (CircleOpts First) where
  diameter v = mempty { circleOptsDiameter = First $ Just v }

instance HasFacets (CircleOpts First) where
  facets v = mempty { circleOptsFacets = First $ Just v }

instance HasPlacement (CircleOpts First) where
  placement v = mempty { circleOptsPlacement = First $ Just v }


circle :: (MonadNeon m) => CircleOpts First -> m Model2D
circle allOpts = do
  fc <- askFacets
  
  let
    opts :: CircleOpts Identity
    opts = bzipWith orDef (fallbackCircleOpts fc) allOpts

    r = get opts.circleOptsDiameter / 2

    handlePlacement m = case get opts.circleOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXY (r, r) m

  handlePlacement $ pure $ Primitive2D $ Circle2D
    { circleDiameter = get opts.circleOptsDiameter
    , circleFacets   = Just (get opts.circleOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 2D / Primitive / Ellipse
-------------------------------------------------------------------------------

data EllipseOpts f = EllipseOpts {
  ellipseOptsSize :: f (V2 Double),
  ellipseOptsPlacement :: f Placement,
  ellipseOptsFacets :: f Facets
}  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (EllipseOpts First)
  instance Semigroup (EllipseOpts First)

deriving via Generically (EllipseOpts First)
  instance Monoid (EllipseOpts First)

fallbackEllipseOpts :: Facets -> EllipseOpts Identity
fallbackEllipseOpts fc = EllipseOpts {
  ellipseOptsSize      = pure defaultEllipseSize,
  ellipseOptsPlacement = pure PlacementCenter,
  ellipseOptsFacets = pure fc
}

ellipse :: MonadNeon m => EllipseOpts First -> m Model2D
ellipse optsMay = do
  
  fc <- askFacets
  let
    opts :: EllipseOpts Identity
    opts = bzipWith orDef (fallbackEllipseOpts fc) optsMay
    
    (dx, dy) = get opts.ellipseOptsSize

    handlePlacement m = case get opts.ellipseOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXY (dx, dy) m

  handlePlacement $ resizeXY (dx, dy) $ circle (diameter (max dx dy) <> facets (get opts.ellipseOptsFacets))

-------------------------------------------------------------------------------
-- / 2D / Primitive / Rect
-------------------------------------------------------------------------------

data RectOpts f = RectOpts {
  rectOptsSize      :: f (V2 Double),
  rectOptsPlacement :: f Placement
}
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (RectOpts First)
  instance Semigroup (RectOpts First)

deriving via Generically (RectOpts First)
  instance Monoid (RectOpts First)

fallbackRectOpts :: RectOpts Identity
fallbackRectOpts = RectOpts {
  rectOptsSize = pure defaultRectSize,
  rectOptsPlacement = pure PlacementCenter
}

instance HasPlacement (RectOpts First) where
  placement v = mempty { rectOptsPlacement = First $ Just v }

instance HasSize (V2 Double) (RectOpts First) where
  size v = mempty { rectOptsSize = First $ Just v }

rect :: MonadNeon m => RectOpts First -> m Model2D
rect opts = pure $ Primitive2D $ Square2D
  { squareSize = get opt.rectOptsSize
  , squareCenter = case get opt.rectOptsPlacement of
      PlacementCenter -> Just True
      PlacementCorner -> Nothing
  }
  where
    opt :: RectOpts Identity
    opt = bzipWith orDef fallbackRectOpts opts

-------------------------------------------------------------------------------
-- / 2D / Primitive / Square
-------------------------------------------------------------------------------

data SquareOpts f = SquareOpts {
  squareOptsSize :: f Double,
  squareOptsPlacement :: f Placement
}
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (SquareOpts First)
  instance Semigroup (SquareOpts First)

deriving via Generically (SquareOpts First)
  instance Monoid (SquareOpts First)


fallbackSquareOpts :: SquareOpts Identity
fallbackSquareOpts = SquareOpts {
  squareOptsSize = pure defaultSquareSize,
  squareOptsPlacement = pure PlacementCenter
}

instance HasSize Double (SquareOpts First) where
  size v = mempty { squareOptsSize = First $ Just v }

instance HasPlacement (SquareOpts First) where
  placement v = mempty { squareOptsPlacement = First $ Just v }

square :: MonadNeon m => SquareOpts First -> m Model2D
square optsMay = pure $ Primitive2D $ Square2D
  { squareSize   = (s, s)
  , squareCenter = case get opts.squareOptsPlacement of
      PlacementCenter -> Just True
      PlacementCorner -> Nothing
  }
  where
    opts :: SquareOpts Identity
    opts = bzipWith orDef fallbackSquareOpts optsMay
    s = get opts.squareOptsSize

-------------------------------------------------------------------------------
-- / 2D / Primitive / Polygon
-------------------------------------------------------------------------------

-- Paths are not supported yet, because they can be modeled with difference.
-- Maybe in the future paths can be added for ergonomics if needed.

data PolygonOpts f = PolygonOpts {
  polygonOptsPoints :: f [V2 Double],
  polygonOptsConvexity :: f Int,
  polygonOptsPlacement :: f Placement
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (PolygonOpts First)
  instance Semigroup (PolygonOpts First)

deriving via Generically (PolygonOpts First)
  instance Monoid (PolygonOpts First)

points :: [V2 Double] -> PolygonOpts First
points ps = mempty { polygonOptsPoints = First $ Just ps }

convexity :: Int -> PolygonOpts First
convexity c = mempty { polygonOptsConvexity = First $ Just c }

instance HasPlacement (PolygonOpts First) where
  placement v = mempty { polygonOptsPlacement = First $ Just v }

fallbackPolygonOpts :: PolygonOpts Identity
fallbackPolygonOpts = PolygonOpts {
  polygonOptsPoints = pure defaultPolygonPoints,
  polygonOptsConvexity = pure defaultConvexity,
  polygonOptsPlacement = pure PlacementCenter
}

polygon :: MonadNeon m => PolygonOpts First -> m Model2D
polygon optsMay = pure $ Primitive2D $ Polygon2D
  { polygonPoints = get opts.polygonOptsPoints
  , polygonConvexity = Just $ get opts.polygonOptsConvexity
  , polygonPaths = Nothing
  }
  where
    opts :: PolygonOpts Identity
    opts = bzipWith orDef fallbackPolygonOpts optsMay

-------------------------------------------------------------------------------
-- / 2D / Primitive / Text
-------------------------------------------------------------------------------

data TextOpts f = TextOpts {
  textOptsText :: f String,
  textOptsFont :: f FontName,
  textOptsSize :: f Double,
  textOptsStyle :: f FontStyle,
  textOptsDirection :: f Direction,
  textOptsHAlign :: f HorizontalAlignment,
  textOptsVAlign :: f VerticalAlignment,
  textOptsSpacing :: f Double
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (TextOpts First)
  instance Semigroup (TextOpts First)

deriving via Generically (TextOpts First)
  instance Monoid (TextOpts First)

fontName :: FontName -> TextOpts First
fontName fn = mempty { textOptsFont = First $ Just fn }

fontStyle :: FontStyle -> TextOpts First
fontStyle fs = mempty { textOptsStyle = First $ Just fs }

fontSize :: Double -> TextOpts First
fontSize size = mempty { textOptsSize = First $ Just size }

direction :: Direction -> TextOpts First
direction dir = mempty { textOptsDirection = First $ Just dir }

hAlign :: HorizontalAlignment -> TextOpts First
hAlign hAlign = mempty { textOptsHAlign = First $ Just hAlign }

vAlign :: VerticalAlignment -> TextOpts First
vAlign vAlign = mempty { textOptsVAlign = First $ Just vAlign }

fontSpacing :: Double -> TextOpts First
fontSpacing spacing = mempty { textOptsSpacing = First $ Just spacing }

str :: String -> TextOpts First
str s = mempty { textOptsText = First $ Just s }


fallbackTextOpts :: TextOpts Identity
fallbackTextOpts = TextOpts {
  textOptsText = pure "Hello, World!",
  textOptsFont = pure FNLiberationSans,
  textOptsSize = pure 10,
  textOptsStyle = pure FSRegular,
  textOptsDirection = pure LeftToRight,
  textOptsHAlign = pure HALeft,
  textOptsVAlign = pure VABaseline,
  textOptsSpacing = pure 1
}

data FontName
  = FNLiberationMono
  | FNLiberationSans
  | FNLiberationSerif
  | FNCustom String
  deriving (Eq)

fontNameToString :: FontName -> String
fontNameToString = \case
  FNLiberationMono -> "Liberation Mono"
  FNLiberationSans -> "Liberation Sans"
  FNLiberationSerif -> "Liberation Serif"
  FNCustom s -> s

data FontStyle
  = FSRegular
  | FSBold
  | FSItalic
  | FSBoldItalic
  deriving (Eq)

fontStyleToString :: FontStyle -> String
fontStyleToString = \case
  FSRegular    -> "Regular"
  FSBold       -> "Bold"
  FSItalic     -> "Italic"
  FSBoldItalic -> "Bold Italic"

mkFont :: Maybe FontName -> Maybe FontStyle -> Maybe Font
mkFont fontName style = case (fontName, style) of
  (Nothing, Nothing) -> Nothing
  (Just fontName, mayStyle) -> Just $ Font
    { fontFamily = fontNameToString fontName
    , fontOptions = case mayStyle of
      Just style -> [("style", fontStyleToString style)]
      Nothing -> []
    }
  (Nothing, mayStyle) -> mkFont (Just FNLiberationSans) mayStyle

text :: MonadNeon m => TextOpts First -> m Model2D
text optsMay = do
  facets <- askFacets
  pure $ Primitive2D $ Text2D
    { textText = get opts.textOptsText
    , textSize = fmap get $ spareOpt opts.textOptsSize 10
    , textFont = mkFont
        (fmap get $ spareOpt opts.textOptsFont (pure FNLiberationSans))
        (fmap get $ spareOpt opts.textOptsStyle (pure FSRegular))
    , textDirection = fmap get $ spareOpt opts.textOptsDirection (pure LeftToRight)
    , textHAlign = fmap get $ spareOpt opts.textOptsHAlign (pure HALeft)
    , textVAlign = fmap get $ spareOpt opts.textOptsVAlign (pure VABaseline)
    , textSpacing = fmap get $ spareOpt opts.textOptsSpacing (pure 1)
    , textEm = Nothing
    , textFacets = Just facets
    , textLanguage = Nothing
    , textScript = Nothing
    }
  where
    opts :: TextOpts Identity
    opts = bzipWith orDef fallbackTextOpts optsMay

-------------------------------------------------------------------------------
-- / 2D / Transform / Offset
-------------------------------------------------------------------------------

offset :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offset d modelM = do
  model <- modelM
  pure $ Transform2D (OffsetDelta2D
    { offsetDeltaDelta = d
    , offsetDeltaChamfer = Nothing
    }) [model]

offsetRound :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offsetRound = undefined

offsetCut :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offsetCut = undefined

-------------------------------------------------------------------------------
-- / 3D / Primitive / Box
-------------------------------------------------------------------------------

data BoxOpts f = BoxOpts {
  boxOptsSize :: f (V3 Double),
  boxOptsPlacement :: f Placement
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (BoxOpts First)
  instance Semigroup (BoxOpts First)

deriving via Generically (BoxOpts First)
  instance Monoid (BoxOpts First)


fallbackBoxOpts :: BoxOpts Identity
fallbackBoxOpts = BoxOpts {
  boxOptsSize = pure defaultBoxSize,
  boxOptsPlacement = pure PlacementCenter
}

instance HasSize (V3 Double) (BoxOpts First) where
  size v = mempty { boxOptsSize = First $ Just v }

instance HasPlacement (BoxOpts First) where
  placement v = mempty { boxOptsPlacement = First $ Just v }

box :: MonadNeon m => BoxOpts First -> m Model3D
box optsMay = pure $ Primitive3D $ Cube3D
  { cubeSize = get opts.boxOptsSize
  , cubeCenter = case get opts.boxOptsPlacement of
      PlacementCenter -> Just True
      PlacementCorner -> Nothing
  }
  where
    opts :: BoxOpts Identity
    opts = bzipWith orDef fallbackBoxOpts optsMay

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cube
-------------------------------------------------------------------------------

data CubeOpts f = CubeOpts {
  cubeOptsSize :: f Double,
  cubeOptsPlacement :: f Placement
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (CubeOpts First)
  instance Semigroup (CubeOpts First)

deriving via Generically (CubeOpts First)
  instance Monoid (CubeOpts First)


fallbackCubeOpts :: CubeOpts Identity
fallbackCubeOpts = CubeOpts {
  cubeOptsSize = pure defaultCubeSize,
  cubeOptsPlacement = pure PlacementCenter
}

instance HasSize Double (CubeOpts First) where
  size v = mempty { cubeOptsSize = First $ Just v }

cube :: MonadNeon m => CubeOpts First -> m Model3D
cube optsMay = pure $ Primitive3D $ Cube3D
  { cubeSize = (s, s, s)
  , cubeCenter = case get opts.cubeOptsPlacement of
      PlacementCenter -> Just True
      PlacementCorner -> Nothing
  }
  where
    s = get opts.cubeOptsSize
    
    opts :: CubeOpts Identity
    opts = bzipWith orDef fallbackCubeOpts optsMay


-------------------------------------------------------------------------------
-- / 3D / Primitive / Cone
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cylinder
-------------------------------------------------------------------------------

data CylinderOpts f = CylinderOpts {
  cylinderOptsHeight    :: f Double,
  cylinderOptsDiameter  :: f Double,
  cylinderOptsPlacement :: f Placement,
  cylinderOptsFacets    :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (CylinderOpts First)
  instance Semigroup (CylinderOpts First)

deriving via Generically (CylinderOpts First)
  instance Monoid (CylinderOpts First)

fallbackCylinderOpts :: Facets -> CylinderOpts Identity
fallbackCylinderOpts fc = CylinderOpts {
  cylinderOptsHeight    = pure defaultCylinderHeight,
  cylinderOptsDiameter  = pure defaultCylinderDiameter,
  cylinderOptsPlacement = pure PlacementCenter,
  cylinderOptsFacets    = pure fc
}

cylinder :: MonadNeon m => CylinderOpts First -> m Model3D
cylinder optsMay = do
  fc <- askFacets
  let
    opts :: CylinderOpts Identity
    opts = bzipWith orDef (fallbackCylinderOpts fc) optsMay
  
    dia = get opts.cylinderOptsDiameter
  pure $ Primitive3D $ Cylinder3D
    { cylinderHeight = get opts.cylinderOptsHeight
    , cylinderCenter = case get opts.cylinderOptsPlacement of
      PlacementCenter -> Just True
      PlacementCorner -> Nothing
    , cylinderDiameter1 = dia
    , cylinderDiameter2 = dia
    , cylinderFacets = Just (get opts.cylinderOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Sphere
-------------------------------------------------------------------------------

data SphereOpts f = SphereOpts {
  sphereOptsDiameter  :: f Double,
  sphereOptsPlacement :: f Placement,
  sphereOptsFacets    :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (SphereOpts First)
  instance Semigroup (SphereOpts First)

deriving via Generically (SphereOpts First)
  instance Monoid (SphereOpts First)


fallbackSphereOpts :: Facets -> SphereOpts Identity
fallbackSphereOpts fc = SphereOpts {
  sphereOptsDiameter = pure defaultSphereDiameter,
  sphereOptsPlacement = pure PlacementCenter,
  sphereOptsFacets = pure fc
}

instance HasDiameter (SphereOpts First) where
  diameter v = mempty { sphereOptsDiameter = First $ Just v }

instance HasPlacement (SphereOpts First) where
  placement v = mempty { sphereOptsPlacement = First $ Just v }

instance HasFacets (SphereOpts First) where
  facets v = mempty { sphereOptsFacets = First $ Just v }

sphere :: MonadNeon m => SphereOpts First -> m Model3D
sphere optsMay = do
  
  fc <- askFacets
  let
    opts :: SphereOpts Identity
    opts = bzipWith orDef (fallbackSphereOpts fc) optsMay

    d = get opts.sphereOptsDiameter
    r = d / 2

    handlePlacement m = case get opts.sphereOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXYZ (r, r, r) m

  handlePlacement $ pure $ Primitive3D $ Sphere3D
    { sphereDiameter = d
    , sphereFacets   = Just (get opts.sphereOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Ellipsoid
-------------------------------------------------------------------------------

data EllipsoidOpts f = EllipsoidOpts {
  ellipsoidOptsSize :: f (V3 Double),
  ellipsoidOptsPlacement :: f Placement,
  ellipsoidOptsFacets :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (EllipsoidOpts First)
  instance Semigroup (EllipsoidOpts First)
  
deriving via Generically (EllipsoidOpts First)
  instance Monoid (EllipsoidOpts First)

fallbackEllipsoidOpts :: Facets -> EllipsoidOpts Identity
fallbackEllipsoidOpts fc = EllipsoidOpts {
  ellipsoidOptsSize = pure defaultEllipsoidSize,
  ellipsoidOptsPlacement = pure PlacementCenter,
  ellipsoidOptsFacets = pure fc
}

instance HasSize (V3 Double) (EllipsoidOpts First) where
  size v = mempty { ellipsoidOptsSize = First $ Just v }

instance HasPlacement (EllipsoidOpts First) where
  placement v = mempty { ellipsoidOptsPlacement = First $ Just v }

ellipsoid :: MonadNeon m => EllipsoidOpts First -> m Model3D
ellipsoid optsMay = do
  
  fc <- askFacets
  let
    opts :: EllipsoidOpts Identity
    opts = bzipWith orDef (fallbackEllipsoidOpts fc) optsMay

    (dx, dy, dz) = get opts.ellipsoidOptsSize
    dmax = max (max dx dy) dz
    
    handlePlacement m = case get opts.ellipsoidOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXYZ (dx, dy, dz) m

  handlePlacement $ resizeXYZ (dx, dy, dz) $ pure $ Primitive3D $ Sphere3D
    { sphereDiameter = dmax
    , sphereFacets = Just (get opts.ellipsoidOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Polyhedron
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 2D-3D Conversion
-------------------------------------------------------------------------------

data ExtrudeLinearOpts f = ExtrudeLinearOpts {
  extrudeLinearOptsHeight      :: f Double,
  extrudeLinearOptsCenter      :: f Bool,
  extrudeLinearOptsScaleFactor :: f Double,
  extrudeLinearOptsTwistAngle  :: f Double,
  extrudeLinearOptsTwistSlices :: f (AutoOrSet Int)
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (ExtrudeLinearOpts First)
  instance Semigroup (ExtrudeLinearOpts First)

deriving via Generically (ExtrudeLinearOpts First)
  instance Monoid (ExtrudeLinearOpts First)

data AutoOrSet a = Auto | Set a

height :: Double -> ExtrudeLinearOpts First
height h = mempty { extrudeLinearOptsHeight = First $ Just h }

centerZ :: ExtrudeLinearOpts First
centerZ = mempty { extrudeLinearOptsCenter = First $ Just True }

scaleFactor :: Double -> ExtrudeLinearOpts First
scaleFactor s = mempty { extrudeLinearOptsScaleFactor = First $ Just s }

fallbackExtrudeLinearOpts :: ExtrudeLinearOpts Identity
fallbackExtrudeLinearOpts = ExtrudeLinearOpts {
  extrudeLinearOptsHeight      = pure defaultLength,
  extrudeLinearOptsCenter      = pure False,
  extrudeLinearOptsScaleFactor = pure 1,
  extrudeLinearOptsTwistAngle  = pure 0,
  extrudeLinearOptsTwistSlices = pure Auto
}

twistAngle :: Double -> ExtrudeLinearOpts First
twistAngle a = mempty { extrudeLinearOptsTwistAngle = First $ Just a }

twistSlices :: Int -> ExtrudeLinearOpts First
twistSlices s = mempty { extrudeLinearOptsTwistSlices = First $ Just (Set s) }

twistSlicesAuto :: ExtrudeLinearOpts First
twistSlicesAuto = mempty { extrudeLinearOptsTwistSlices = First $ Just Auto }

extrudeLinear :: (MonadNeon m) => ExtrudeLinearOpts First -> m Model2D -> m Model3D
extrudeLinear optsMay modelM = do
  model <- modelM
  facets <- askFacets
  pure $ Extrude3D (LinearExtrude
    { linearHeight    = get opts.extrudeLinearOptsHeight
    , linearCenter    = spareFlag (get opts.extrudeLinearOptsCenter)
    , linearTwist     = spareOpt (get opts.extrudeLinearOptsTwistAngle) 0
    , linearScale     = spareOpt (get opts.extrudeLinearOptsScaleFactor) 1
    , linearSlices    = case get opts.extrudeLinearOptsTwistSlices of
        Set s -> Just s
        Auto -> Nothing
    , linearConvexity = Just defaultConvexity
    , linearFacets    = Nothing
  }) [model]
  where
    opts :: ExtrudeLinearOpts Identity
    opts = bzipWith orDef fallbackExtrudeLinearOpts optsMay

-------------------------------------------------------------------------------

data ExtrudeRotationalOpts f = ExtrudeRotationalOpts {
  extrudeRotationalOptsAngle :: f Double,
  extrudeRotationalOptsConvexity :: f Int,
  extrudeRotationalOptsFacets :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (ExtrudeRotationalOpts First)
  instance Semigroup (ExtrudeRotationalOpts First)

deriving via Generically (ExtrudeRotationalOpts First)
  instance Monoid (ExtrudeRotationalOpts First)

fallbackExtrudeRotationalOpts :: Facets -> ExtrudeRotationalOpts Identity
fallbackExtrudeRotationalOpts fc = ExtrudeRotationalOpts {
  extrudeRotationalOptsAngle = pure 360,
  extrudeRotationalOptsConvexity = pure defaultConvexity,
  extrudeRotationalOptsFacets = pure fc
}

extrudeRotational :: (MonadNeon m) => ExtrudeRotationalOpts First -> m Model2D -> m Model3D
extrudeRotational optsMay modelM = do
  model <- modelM
  facets <- askFacets
  
  let opts :: ExtrudeRotationalOpts Identity
      opts = bzipWith orDef (fallbackExtrudeRotationalOpts facets) optsMay

  pure $ Extrude3D (RotateExtrude
    { rotateAngle = get opts.extrudeRotationalOptsAngle
    , rotateConvexity = Just (get opts.extrudeRotationalOptsConvexity)
    , rotateFacets = Just (get opts.extrudeRotationalOptsFacets)
    })
    [model]

----

project :: (MonadNeon m) => m Model3D -> m Model2D
project = undefined

-------------------------------------------------------------------------------
-- / Helpers
-------------------------------------------------------------------------------

spareOpt :: Eq a => a -> a -> Maybe a
spareOpt x y = if x == y then Nothing else Just x

spareFlag :: Bool -> Maybe Bool
spareFlag b = spareOpt b False

orDef :: Identity a -> First a -> Identity a
orDef def opt = pure $ fromMaybe (runIdentity def) (getFirst opt)

mappendFirst :: Maybe a -> Maybe a -> Maybe a
mappendFirst a b = getFirst $ First a <> First b

get :: Identity a -> a
get = runIdentity

-------------------------------------------------------------------------------
-- / Rendering
-------------------------------------------------------------------------------

render2D :: Model2D -> String
render2D = OpenSCAD.render2D

render3D :: Model3D -> String
render3D = OpenSCAD.render3D