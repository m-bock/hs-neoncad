{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}


module NeonCAD (
  comment,
  render2D, render3D,

  diameter, radius,
  facets,
  center, corner,
  scale,
  size,
  HasSize, HasPlacement,

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

  empty,

  -- Transform
  union, unions,
  intersection, intersections,
  difference,
  scale,
  resizeXYZ, resizeXY, resizeXZ, resizeYZ, resizeX, resizeY, resizeZ,
  resizeAutoXY, resizeAutoXZ, resizeAutoYZ, resizeAutoX, resizeAutoY, resizeAutoZ,
  moveXYZ, moveXY, moveXZ, moveYZ, moveX, moveY, moveZ,
  spinXYZ, spinXY, spinXZ, spinYZ, spinX, spinY, spinZ,
  mirrorXYZ, mirrorXY, mirrorXZ, mirrorYZ, mirrorX, mirrorY, mirrorZ,
  color, rgb, alpha, Color,
  hull,

  -- 2D-3D Conversion
  extrudeLinear, extrudeWithSpin,

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
import GHC.Generics (Generic, Generically(..))

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
-- / Classes / IsOpts
-------------------------------------------------------------------------------

class (Monoid (a First)) => IsOpts a where
  getOpts :: a First -> a Identity

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

class Comment a m where
  comment :: String -> m a -> m a

instance MonadNeon m => Comment Model2D m where
  comment txt modelM = do
    model <- modelM
    pure $ Comment2D txt model

instance MonadNeon m => Comment Model3D m where
  comment txt modelM = do
    model <- modelM
    pure $ Comment3D txt model

-------------------------------------------------------------------------------
-- / Classes / Scale
-------------------------------------------------------------------------------

class ScaleXYZ a m where
  scaleXYZ :: V3 Double -> m a -> m a

class ScaleXY a m where
  scaleXY :: V2 Double -> m a -> m a

class ScaleXZ a m where
  scaleXZ :: V2 Double -> m a -> m a

class ScaleYZ a m where
  scaleYZ :: V2 Double -> m a -> m a

class ScaleX a m where
  scaleX :: Double -> m a -> m a

class ScaleY a m where
  scaleY :: Double -> m a -> m a

class ScaleZ a m where
  scaleZ :: Double -> m a -> m a

class Scale a m where
  scale :: Double -> m a -> m a

-- * 2D

instance MonadNeon m => ScaleXY Model2D m where
  scaleXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Scale2D (x, y)) [model]

instance MonadNeon m => ScaleX Model2D m where
  scaleX x modelM = scaleXY (x, 1) modelM

instance MonadNeon m => ScaleY Model2D m where
  scaleY y modelM = scaleXY (1, y) modelM

instance MonadNeon m => Scale Model2D m where
  scale x modelM = scaleXY (x, x) modelM

-- * 3D

instance MonadNeon m => ScaleXYZ Model3D m where
  scaleXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Scale3D v) [model]

instance MonadNeon m => ScaleXY Model3D m where
  scaleXY (x, y) modelM = scaleXYZ (x, y, 1) modelM
  
instance MonadNeon m => ScaleXZ Model3D m where
  scaleXZ (x, z) modelM = scaleXYZ (x, 1, z) modelM

instance MonadNeon m => ScaleYZ Model3D m where
  scaleYZ (y, z) modelM = scaleXYZ (1, y, z) modelM

instance MonadNeon m => ScaleX Model3D m where
  scaleX x modelM = scaleXYZ (x, 1, 1) modelM

instance MonadNeon m => ScaleY Model3D m where
  scaleY y modelM = scaleXYZ (1, y, 1) modelM

instance MonadNeon m => Scale Model3D m where
  scale x modelM = scaleXYZ (x, x, x) modelM

-------------------------------------------------------------------------------
-- / Classes / Move
-------------------------------------------------------------------------------

class MoveXYZ a m where
  moveXYZ :: V3 Double -> m a -> m a

class MoveXY a m where
  moveXY :: V2 Double -> m a -> m a

class MoveXZ a m where
  moveXZ :: V2 Double -> m a -> m a

class MoveYZ a m where
  moveYZ :: V2 Double -> m a -> m a

class MoveX a m where
  moveX :: Double -> m a -> m a

class MoveY a m where
  moveY :: Double -> m a -> m a

class MoveZ a m where
  moveZ :: Double -> m a -> m a

-- * 2D

instance MonadNeon m => MoveXY Model2D m where
  moveXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (x, y, 0)) [model]

instance MonadNeon m => MoveX Model2D m where
  moveX x modelM = moveXY (x, 0) modelM

instance MonadNeon m => MoveY Model2D m where
  moveY y modelM = moveXY (0, y) modelM

instance MonadNeon m => MoveZ Model2D m where
  moveZ z modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (0, 0, z)) [model]


-- * 3D

instance MonadNeon m => MoveXYZ Model3D m where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Translate3D v) [model]

instance MonadNeon m => MoveXY Model3D m where
  moveXY (x, y) modelM = moveXYZ (x, y, 0) modelM

instance MonadNeon m => MoveXZ Model3D m where
  moveXZ (x, z) modelM = moveXYZ (x, 0, z) modelM

instance MonadNeon m => MoveYZ Model3D m where
  moveYZ (y, z) modelM = moveXYZ (0, y, z) modelM

instance MonadNeon m => MoveX Model3D m where
  moveX x modelM = moveXYZ (x, 0, 0) modelM

instance MonadNeon m => MoveY Model3D m where
  moveY y modelM = moveXYZ (0, y, 0) modelM

instance MonadNeon m => MoveZ Model3D m where
  moveZ z modelM = moveXYZ (0, 0, z) modelM


-------------------------------------------------------------------------------
-- / Classes / Resize
-------------------------------------------------------------------------------

class ResizeXYZ a m where
  resizeXYZ :: V3 Double -> m a -> m a

class ResizeXY a m where
  resizeXY :: V2 Double -> m a -> m a

class ResizeXZ a m where
  resizeXZ :: V2 Double -> m a -> m a

class ResizeYZ a m where
  resizeYZ :: V2 Double -> m a -> m a

class ResizeX a m where
  resizeX :: Double -> m a -> m a

class ResizeY a m where
  resizeY :: Double -> m a -> m a

class ResizeZ a m where
  resizeZ :: Double -> m a -> m a


-- * 2D

instance MonadNeon m => ResizeXY Model2D m where
  resizeXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, y) Nothing) [model]
    
    
instance MonadNeon m => ResizeX Model2D m where
  resizeX x modelM = resizeXY (x, 1) modelM

instance MonadNeon m => ResizeY Model2D m where
  resizeY y modelM = resizeXY (1, y) modelM


-- * 3D

instance MonadNeon m => ResizeXYZ Model3D m where
  resizeXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, z) Nothing) [model]
    
instance MonadNeon m => ResizeXY Model3D m where
  resizeXY (x, y) modelM = resizeXYZ (x, y, 0) modelM
  
instance MonadNeon m => ResizeXZ Model3D m where
  resizeXZ (x, z) modelM = resizeXYZ (x, 1, z) modelM

instance MonadNeon m => ResizeYZ Model3D m where
  resizeYZ (y, z) modelM = resizeXYZ (1, y, z) modelM

instance MonadNeon m => ResizeX Model3D m where
  resizeX x modelM = resizeXYZ (x, 1, 1) modelM

instance MonadNeon m => ResizeY Model3D m where
  resizeY y modelM = resizeXYZ (1, y, 1) modelM

instance MonadNeon m => ResizeZ Model3D m where
  resizeZ z modelM = resizeXYZ (1, 1, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Resize Auto
-------------------------------------------------------------------------------

class ResizeAutoXY a m where
  resizeAutoXY :: V2 Double -> m a -> m a

class ResizeAutoXZ a m where
  resizeAutoXZ :: V2 Double -> m a -> m a

class ResizeAutoYZ a m where
  resizeAutoYZ :: V2 Double -> m a -> m a

class ResizeAutoX a m where
  resizeAutoX :: Double -> m a -> m a

class ResizeAutoY a m where
  resizeAutoY :: Double -> m a -> m a

class ResizeAutoZ a m where
  resizeAutoZ :: Double -> m a -> m a


-- * 2D

instance MonadNeon m => ResizeAutoX Model2D m where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, 0) (Just (False, True))) [model]

instance MonadNeon m => ResizeAutoY Model2D m where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (0, y) (Just (True, False))) [model]


-- * 3D

instance MonadNeon m => ResizeAutoXY Model3D m where
  resizeAutoXY (x, y) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, 0) (Just (False, False, True))) [model]
  
instance MonadNeon m => ResizeAutoXZ Model3D m where
  resizeAutoXZ (x, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, z) (Just (False, True, False))) [model]
  
instance MonadNeon m => ResizeAutoYZ Model3D m where
  resizeAutoYZ (y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, z) (Just (True, False, False))) [model]

instance MonadNeon m => ResizeAutoX Model3D m where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, 0) (Just (False, True, True))) [model]

instance MonadNeon m => ResizeAutoY Model3D m where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, 0) (Just (True, False, True))) [model]

instance MonadNeon m => ResizeAutoZ Model3D m where
  resizeAutoZ z modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, 0, z) (Just (True, True, False))) [model]


-------------------------------------------------------------------------------
-- / Classes / Spin
-------------------------------------------------------------------------------

class SpinXYZ a m where
  spinXYZ :: V3 Double -> m a -> m a

class SpinXY a m where
  spinXY :: V2 Double -> m a -> m a

class SpinXZ a m where
  spinXZ :: V2 Double -> m a -> m a

class SpinYZ a m where
  spinYZ :: V2 Double -> m a -> m a

class SpinX a m where
  spinX :: Double -> m a -> m a

class SpinY a m where
  spinY :: Double -> m a -> m a

class SpinZ a m where
  spinZ :: Double -> m a -> m a


-- * 2D

instance MonadNeon m => SpinZ Model2D m where
  spinZ z modelM = do
    model <- modelM
    pure $ Transform2D (RotateEuler2D (0, 0, z)) [model]


-- * 3D

instance MonadNeon m => SpinXYZ Model3D m where
  spinXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (RotateEuler3D (x, y, z)) [model]

instance MonadNeon m => SpinXY Model3D m where
  spinXY (x, y) modelM = spinXYZ (x, y, 0) modelM

instance MonadNeon m => SpinXZ Model3D m where
  spinXZ (x, z) modelM = spinXYZ (x, 0, z) modelM

instance MonadNeon m => SpinYZ Model3D m where
  spinYZ (y, z) modelM = spinXYZ (0, y, z) modelM

instance MonadNeon m => SpinX Model3D m where
  spinX x modelM = spinXYZ (x, 0, 0) modelM

instance MonadNeon m => SpinY Model3D m where
  spinY y modelM = spinXYZ (0, y, 0) modelM

instance MonadNeon m => SpinZ Model3D m where
  spinZ z modelM = spinXYZ (0, 0, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Mirror
-------------------------------------------------------------------------------

class MirrorXYZ a m where
  mirrorXYZ :: V3 Double -> m a -> m a

class MirrorXY a m where
  mirrorXY :: V2 Double -> m a -> m a

class MirrorXZ a m where
  mirrorXZ :: V2 Double -> m a -> m a

class MirrorYZ a m where
  mirrorYZ :: V2 Double -> m a -> m a

class MirrorX a m where
  mirrorX :: m a -> m a

class MirrorY a m where
  mirrorY :: m a -> m a

class MirrorZ a m where
  mirrorZ :: Double -> m a -> m a


-- * 2D

instance MonadNeon m => MirrorX Model2D m where
  mirrorX modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (0, 1)) [model]


instance MonadNeon m => MirrorY Model2D m where
  mirrorY modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (1, 0)) [model]

instance MonadNeon m => MirrorXY Model2D m where
  mirrorXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (x, y)) [model]

-- * 3D

instance MonadNeon m => MirrorXYZ Model3D m where
  mirrorXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Mirror3D (x, y, z)) [model]

instance MonadNeon m => MirrorXY Model3D m where
  mirrorXY (x, y) modelM = mirrorXYZ (x, y, 0) modelM

instance MonadNeon m => MirrorXZ Model3D m where
  mirrorXZ (x, z) modelM = mirrorXYZ (x, 0, z) modelM

instance MonadNeon m => MirrorYZ Model3D m where
  mirrorYZ (y, z) modelM = mirrorXYZ (0, y, z) modelM

instance MonadNeon m => MirrorX Model3D m where
  mirrorX modelM = mirrorXYZ (1, 0, 0) modelM

instance MonadNeon m => MirrorY Model3D m where
  mirrorY modelM = mirrorXYZ (0, 1, 0) modelM

instance MonadNeon m => MirrorZ Model3D m where
  mirrorZ z modelM = mirrorXYZ (0, 0, z) modelM

-------------------------------------------------------------------------------
-- / Classes / Color
-------------------------------------------------------------------------------

data ColorOpts f = ColorOpts {
  colorOptsRgb :: f (V3 Double),
  colorOptsAlpha :: f Double
} 
  deriving stock Generic

deriving via Generically (ColorOpts First)
  instance Semigroup (ColorOpts First)

deriving via Generically (ColorOpts First)
  instance Monoid (ColorOpts First)

instance IsOpts ColorOpts where
  getOpts opt = ColorOpts {
    colorOptsRgb   = orDef (0, 0, 0) opt.colorOptsRgb,
    colorOptsAlpha = orDef 1         opt.colorOptsAlpha
  }

class Color a m where
  color :: ColorOpts First -> m a -> m a

rgb :: V3 Double -> ColorOpts First
rgb rgbValues = mempty { colorOptsRgb = First $ Just rgbValues }

alpha :: Double -> ColorOpts First
alpha alphaValue = mempty { colorOptsAlpha = First $ Just alphaValue }

-- * 2D

instance MonadNeon m => Color Model2D m where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform2D (Color2D (get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts = getOpts optsMay

-- * 3D

instance MonadNeon m => Color Model3D m where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform3D (Color3D (get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts = getOpts optsMay

-------------------------------------------------------------------------------
-- / Classes / Hull
-------------------------------------------------------------------------------

class Hull a m where
  hull :: m a -> m a

-- * 2D

instance MonadNeon m => Hull Model2D m where
  hull modelM = do
    model <- modelM
    pure $ Transform2D Hull2D [model]


-- * 3D

instance MonadNeon m => Hull Model3D m where
  hull modelM = do
    model <- modelM
    pure $ Transform3D Hull3D [model]

-------------------------------------------------------------------------------
-- / Classes / Union
-------------------------------------------------------------------------------

class Union a m where
  union :: m a -> m a -> m a
  unions :: [m a] -> m a


-- * 2D

instance MonadNeon m => Union Model2D m where
  union modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Union2D [modelA, modelB]

  unions modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Union2D models


-- * 3D

instance MonadNeon m => Union Model3D m where
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

class Empty a m where
  empty :: m a


-- * 2D

instance MonadNeon m => Empty Model2D m where
  empty = pure $ BoolOp2D Union2D []


-- * 3D

instance MonadNeon m => Empty Model3D m where
  empty = pure $ BoolOp3D Union3D []

-------------------------------------------------------------------------------
-- / Classes / Intersection
-------------------------------------------------------------------------------

class Intersection a m where
  intersection :: m a -> m a -> m a
  intersections :: [m a] -> m a


-- * 2D

instance MonadNeon m => Intersection Model2D m where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Intersection2D [modelA, modelB]

  intersections modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Intersection2D models


-- * 3D

instance MonadNeon m => Intersection Model3D m where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Intersection3D [modelA, modelB]

-------------------------------------------------------------------------------
-- / Classes / Difference
-------------------------------------------------------------------------------

class Difference a m where
  difference :: m a -> m a -> m a


-- * 2D

instance MonadNeon m => Difference Model2D m where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Difference2D [modelA, modelB]


-- * 3D

instance MonadNeon m => Difference Model3D m where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Difference3D [modelA, modelB]

-------------------------------------------------------------------------------
-- / Classes / Modifiers
-------------------------------------------------------------------------------

class Modifiers a m where
  modDisable :: m a -> m a
  modShowOnly :: m a -> m a
  modHighlight :: m a -> m a
  modTransparent :: m a -> m a


-- * 2D

instance MonadNeon m => Modifiers Model2D m where
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

instance MonadNeon m => Modifiers Model3D m where
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
} deriving stock Generic

deriving via Generically (CircleOpts First)
  instance Semigroup (CircleOpts First)

deriving via Generically (CircleOpts First)
  instance Monoid (CircleOpts First)

instance IsOpts CircleOpts where
  getOpts opt =
    CircleOpts {
      circleOptsDiameter  = orDef defaultCircleDiameter opt.circleOptsDiameter,
      circleOptsPlacement = orDef PlacementCenter       opt.circleOptsPlacement,
      circleOptsFacets    = orDef defaultFacets         opt.circleOptsFacets
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
  pure $ handlePlacement $ Primitive2D $ Circle2D
    { circleDiameter = get opts.circleOptsDiameter
    , circleFacets   = Just fc
    }
  where
    opts :: CircleOpts Identity
    opts = getOpts allOpts

    r = get opts.circleOptsDiameter / 2

    handlePlacement :: Model2D -> Model2D
    handlePlacement m = case get opts.circleOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> Transform2D (Translate2D (r, r, 0)) [m]

-------------------------------------------------------------------------------
-- / 2D / Primitive / Ellipse
-------------------------------------------------------------------------------

data EllipseOpts f = EllipseOpts {
  ellipseOptsSize :: f (V2 Double),
  ellipseOptsPlacement :: f Placement
} 
  deriving stock Generic

deriving via Generically (EllipseOpts First)
  instance Semigroup (EllipseOpts First)

deriving via Generically (EllipseOpts First)
  instance Monoid (EllipseOpts First)

instance IsOpts EllipseOpts where
  getOpts opt = EllipseOpts {
    ellipseOptsSize      = orDef defaultEllipseSize opt.ellipseOptsSize,
    ellipseOptsPlacement = orDef PlacementCenter opt.ellipseOptsPlacement
  }

ellipse :: MonadNeon m => EllipseOpts First -> m Model2D
ellipse optsMay = handlePlacement $ resizeXY (dx, dy) $ circle (diameter (max dx dy))
  where
    (dx, dy) = get opts.ellipseOptsSize

    handlePlacement :: MonadNeon m => m Model2D -> m Model2D
    handlePlacement m = case get opts.ellipseOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXY (dx, dy) m

    opts = getOpts optsMay

-------------------------------------------------------------------------------
-- / 2D / Primitive / Rect
-------------------------------------------------------------------------------

data RectOpts f = RectOpts {
  rectOptsSize      :: f (V2 Double),
  rectOptsPlacement :: f Placement
}
  deriving stock Generic

deriving via Generically (RectOpts First)
  instance Semigroup (RectOpts First)

deriving via Generically (RectOpts First)
  instance Monoid (RectOpts First)

instance IsOpts RectOpts where
  getOpts opt = RectOpts {
    rectOptsSize      = orDef defaultRectSize opt.rectOptsSize,
    rectOptsPlacement = orDef PlacementCenter opt.rectOptsPlacement
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
    opt = getOpts opts

-------------------------------------------------------------------------------
-- / 2D / Primitive / Square
-------------------------------------------------------------------------------

data SquareOpts f = SquareOpts {
  squareOptsSize :: f Double,
  squareOptsPlacement :: f Placement
}
  deriving stock Generic

deriving via Generically (SquareOpts First)
  instance Semigroup (SquareOpts First)

deriving via Generically (SquareOpts First)
  instance Monoid (SquareOpts First)

instance IsOpts SquareOpts where
  getOpts opt = SquareOpts {
    squareOptsSize = orDef defaultSquareSize opt.squareOptsSize,
    squareOptsPlacement = orDef PlacementCenter opt.squareOptsPlacement
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
    opts = getOpts optsMay
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
  deriving stock Generic

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

instance IsOpts PolygonOpts where
  getOpts opt = PolygonOpts {
    polygonOptsPoints = orDef defaultPolygonPoints opt.polygonOptsPoints,
    polygonOptsConvexity = orDef defaultConvexity opt.polygonOptsConvexity,
    polygonOptsPlacement = orDef PlacementCenter opt.polygonOptsPlacement
  }

polygon :: MonadNeon m => PolygonOpts First -> m Model2D
polygon optsMay = pure $ Primitive2D $ Polygon2D
  { polygonPoints = get opts.polygonOptsPoints
  , polygonConvexity = Just $ get opts.polygonOptsConvexity
  , polygonPaths = Nothing
  }
  where
    opts = getOpts optsMay

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
  deriving stock Generic

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


instance IsOpts TextOpts where
  getOpts opt = TextOpts {
    textOptsText = orDef "Hello, World!" opt.textOptsText,
    textOptsFont = orDef FNLiberationSans opt.textOptsFont,
    textOptsSize = orDef 10 opt.textOptsSize,
    textOptsStyle = orDef FSRegular opt.textOptsStyle,
    textOptsDirection = orDef LeftToRight opt.textOptsDirection,
    textOptsHAlign = orDef HALeft opt.textOptsHAlign,
    textOptsVAlign = orDef VABaseline opt.textOptsVAlign,
    textOptsSpacing = orDef 1 opt.textOptsSpacing
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
    opts = getOpts optsMay

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
-- / 2D / Extrude / Rotational
-------------------------------------------------------------------------------

extrudeWithSpin :: (MonadNeon m) => Double -> m Model2D -> m Model3D
extrudeWithSpin height modelM = do
  model <- modelM
  facets <- askFacets
  pure $ Extrude3D RotateExtrude
    { rotateAngle = height
    , rotateConvexity = Nothing
    , rotateFacets = Just facets
    }
    [model]

-------------------------------------------------------------------------------
-- / 3D / Primitive / Box
-------------------------------------------------------------------------------

data BoxOpts f = BoxOpts {
  boxOptsSize :: f (V3 Double),
  boxOptsPlacement :: f Placement
} 
  deriving stock Generic

deriving via Generically (BoxOpts First)
  instance Semigroup (BoxOpts First)

deriving via Generically (BoxOpts First)
  instance Monoid (BoxOpts First)

instance IsOpts BoxOpts where
  getOpts opt = BoxOpts {
    boxOptsSize      = orDef defaultBoxSize opt.boxOptsSize,
    boxOptsPlacement = orDef PlacementCenter opt.boxOptsPlacement
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
    opts = getOpts optsMay

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cube
-------------------------------------------------------------------------------

data CubeOpts f = CubeOpts {
  cubeOptsSize :: f Double,
  cubeOptsPlacement :: f Placement
} 
  deriving stock Generic

deriving via Generically (CubeOpts First)
  instance Semigroup (CubeOpts First)

deriving via Generically (CubeOpts First)
  instance Monoid (CubeOpts First)

instance IsOpts CubeOpts where
  getOpts opt = CubeOpts {
    cubeOptsSize      = orDef defaultCubeSize opt.cubeOptsSize,
    cubeOptsPlacement = orDef PlacementCenter opt.cubeOptsPlacement
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
    opts = getOpts optsMay


-------------------------------------------------------------------------------
-- / 3D / Primitive / Cone
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cylinder
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Primitive / Sphere
-------------------------------------------------------------------------------

data SphereOpts f = SphereOpts {
  sphereOptsDiameter  :: f Double,
  sphereOptsPlacement :: f Placement,
  sphereOptsFacets    :: f Facets
} 
  deriving stock Generic

deriving via Generically (SphereOpts First)
  instance Semigroup (SphereOpts First)

deriving via Generically (SphereOpts First)
  instance Monoid (SphereOpts First)

instance IsOpts SphereOpts where
  getOpts opt = SphereOpts {
    sphereOptsDiameter  = orDef defaultSphereDiameter opt.sphereOptsDiameter,
    sphereOptsPlacement = orDef PlacementCenter     opt.sphereOptsPlacement,
    sphereOptsFacets    = orDef defaultFacets       opt.sphereOptsFacets
  }

instance HasDiameter (SphereOpts First) where
  diameter v = mempty { sphereOptsDiameter = First $ Just v }

instance HasPlacement (SphereOpts First) where
  placement v = mempty { sphereOptsPlacement = First $ Just v }

instance HasFacets (SphereOpts First) where
  facets v = mempty { sphereOptsFacets = First $ Just v }

sphere :: MonadNeon m => SphereOpts First -> m Model3D
sphere optsMay = handlePlacement $ pure $ Primitive3D $ Sphere3D
  { sphereDiameter = get opts.sphereOptsDiameter
  , sphereFacets   = Just (get opts.sphereOptsFacets)
  }
  where
    opts = getOpts optsMay

    d = get opts.sphereOptsDiameter
    r = d / 2

    handlePlacement :: MonadNeon m => m Model3D -> m Model3D
    handlePlacement m = case get opts.sphereOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXYZ (r, r, r) m

-------------------------------------------------------------------------------
-- / 3D / Primitive / Ellipsoid
-------------------------------------------------------------------------------

data EllipsoidOpts f = EllipsoidOpts {
  ellipsoidOptsSize :: f (V3 Double),
  ellipsoidOptsPlacement :: f Placement,
  ellipsoidOptsFacets :: f Facets
} 
  deriving stock Generic

deriving via Generically (EllipsoidOpts First)
  instance Semigroup (EllipsoidOpts First)
  
deriving via Generically (EllipsoidOpts First)
  instance Monoid (EllipsoidOpts First)

instance IsOpts EllipsoidOpts where
  getOpts opt = EllipsoidOpts {
    ellipsoidOptsSize      = orDef defaultEllipsoidSize opt.ellipsoidOptsSize,
    ellipsoidOptsPlacement = orDef PlacementCenter opt.ellipsoidOptsPlacement,
    ellipsoidOptsFacets    = orDef defaultFacets opt.ellipsoidOptsFacets
  }

instance HasSize (V3 Double) (EllipsoidOpts First) where
  size v = mempty { ellipsoidOptsSize = First $ Just v }

instance HasPlacement (EllipsoidOpts First) where
  placement v = mempty { ellipsoidOptsPlacement = First $ Just v }

ellipsoid :: MonadNeon m => EllipsoidOpts First -> m Model3D
ellipsoid optsMay = handleResize $ handlePlacement $ pure $ Primitive3D $ Sphere3D
  { sphereDiameter = dmax
  , sphereFacets = Just (get opts.ellipsoidOptsFacets)
  }
  where
    handleResize :: MonadNeon m => m Model3D -> m Model3D
    handleResize m = case get opts.ellipsoidOptsSize of
      (dx, dy, dz) -> resizeXYZ (dx, dy, dz) m

    handlePlacement :: MonadNeon m => m Model3D -> m Model3D
    handlePlacement m = case get opts.ellipsoidOptsPlacement of
      PlacementCenter -> m
      PlacementCorner -> moveXYZ (dx, dy, dz) m

    (dx, dy, dz) = get opts.ellipsoidOptsSize
    dmax = max (max dx dy) dz
    opts = getOpts optsMay

-------------------------------------------------------------------------------
-- / 3D / Primitive / Polyhedron
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 2D-3D Conversion
-------------------------------------------------------------------------------

extrudeLinear :: (MonadNeon m) => Double -> m Model2D -> m Model3D
extrudeLinear height = extrudeLineaWith height mempty

extrudeLinearCenter :: (MonadNeon m) => Double -> m Model2D -> m Model3D
extrudeLinearCenter height = extrudeLineaWith height centerExtr

data ExtrudeLinearOpts = ExtrudeLinearOpts {
  center :: Bool,
  scale :: Maybe Double,
  twist :: Twist
}

instance Semigroup ExtrudeLinearOpts where
  a <> b = ExtrudeLinearOpts {
    center = a.center || b.center,
    scale = case (a.scale, b.scale) of
      (Nothing, Nothing) -> Nothing
      (Just s, Nothing) -> Just s
      (Nothing, Just s) -> Just s
      (Just s1, Just s2) -> Just s1,
    twist = case (a.twist, b.twist) of
      (NoTwist, NoTwist) -> NoTwist
      (Twist t o, NoTwist) -> Twist t o
      (NoTwist, Twist t o) -> Twist t o
      (Twist t1 o1, Twist t2 o2) -> Twist t1 o1
   }

instance Monoid ExtrudeLinearOpts where
  mempty = ExtrudeLinearOpts {
    center = False,
    scale = Nothing,
    twist = NoTwist
  }

defaultExtrudeLinearOpts :: ExtrudeLinearOpts
defaultExtrudeLinearOpts = ExtrudeLinearOpts {
  center = False,
  scale = Nothing,
  twist = NoTwist
}

centerExtr :: ExtrudeLinearOpts
centerExtr = defaultExtrudeLinearOpts { center = True }

scaleFactor :: Double -> ExtrudeLinearOpts
scaleFactor s = defaultExtrudeLinearOpts { scale = Just s }

twist :: Double -> ExtrudeLinearOpts
twist a = defaultExtrudeLinearOpts { twist = Twist a Nothing }

twistWithSlices :: Double -> Int -> ExtrudeLinearOpts
twistWithSlices a s = defaultExtrudeLinearOpts { twist = Twist a (Just s) }

extrudeLineaWith :: (MonadNeon m) => Double -> ExtrudeLinearOpts -> m Model2D -> m Model3D
extrudeLineaWith height opts modelM = do
  model <- modelM
  facets <- askFacets
  pure $ Extrude3D (LinearExtrude
    { linearHeight    = height
    , linearCenter    = if opts.center then Just True else Nothing
    , linearTwist     = case opts.twist of
        NoTwist -> Nothing
        Twist a _ -> Just a
    , linearScale     = opts.scale
    , linearSlices    = case opts.twist of
        Twist _ (Just s) -> Just s
        _ -> Nothing
    , linearConvexity = Just defaultConvexity
    , linearFacets    = Just facets
  }) [model]

data Twist = NoTwist | Twist {
  angle :: Double,
  slices :: Maybe Int
}

----

extrudeRotational :: (MonadNeon m) => Double -> m Model2D -> m Model3D
extrudeRotational = undefined

project :: (MonadNeon m) => m Model3D -> m Model2D
project = undefined

-------------------------------------------------------------------------------
-- / Helpers
-------------------------------------------------------------------------------

spareOpt :: Eq a => a -> a -> Maybe a
spareOpt x y = if x == y then Nothing else Just x

spareFlag :: Bool -> Maybe Bool
spareFlag b = spareOpt b False

orDef :: a -> First a -> Identity a
orDef def opt = pure $ fromMaybe def (getFirst opt)

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