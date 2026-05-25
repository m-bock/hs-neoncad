{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use <$>" #-}

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
  polygon,
  text, defaultTextOpts, TextOpts, FontName, FontStyle,

  offset, offsetRound, offsetCut,

  -- 3D / Primitive
  box, boxCenter,
  cube, cubeCenter,

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

defaultFacets :: Facets
defaultFacets = Facets
  { fn = Nothing
  , fa = Just 6
  , fs = Just 0.5
  }

-------------------------------------------------------------------------------
-- / Classes
-------------------------------------------------------------------------------

class (Monad m) => MonadNeon m where
  askFacets :: m Facets
  localFacets :: Facets -> m a -> m a

-------------------------------------------------------------------------------
-- / Classes / IsOpts
-------------------------------------------------------------------------------

class (Monoid (a Maybe)) => IsOpts a where
  getOpts :: a Maybe -> a Identity

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
  facets :: Int -> a

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

instance Monoid (ColorOpts Maybe) where
  mempty = ColorOpts {
    colorOptsRgb = Nothing,
    colorOptsAlpha = Nothing
  }

instance Semigroup (ColorOpts Maybe) where
  a <> b = ColorOpts {
    colorOptsRgb = mappendFirst a.colorOptsRgb b.colorOptsRgb,
    colorOptsAlpha = mappendFirst a.colorOptsAlpha b.colorOptsAlpha
  }

instance IsOpts ColorOpts where
  getOpts opt = ColorOpts {
    colorOptsRgb   = orDef (0, 0, 0) opt.colorOptsRgb,
    colorOptsAlpha = orDef 1         opt.colorOptsAlpha
  }

class Color a m where
  color :: ColorOpts Maybe -> m a -> m a

rgb :: V3 Double -> ColorOpts Maybe
rgb rgbValues = ColorOpts {
  colorOptsRgb = Just rgbValues,
  colorOptsAlpha = Nothing
}

alpha :: Double -> ColorOpts Maybe
alpha alphaValue = ColorOpts {
  colorOptsRgb = Nothing,
  colorOptsAlpha = Just alphaValue
}

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
  circleOptsDiameter   :: f Double,
  circleOptsPlacement :: f Placement,
  circleOptsFacets     :: f Int
}

instance Monoid (CircleOpts Maybe) where
  mempty = CircleOpts {
    circleOptsDiameter   = Nothing,
    circleOptsPlacement = Nothing,
    circleOptsFacets     = Nothing
  }

instance Semigroup (CircleOpts Maybe) where
  a <> b = CircleOpts {
    circleOptsDiameter  = mappendFirst a.circleOptsDiameter  b.circleOptsDiameter,
    circleOptsPlacement = mappendFirst a.circleOptsPlacement b.circleOptsPlacement,
    circleOptsFacets    = mappendFirst a.circleOptsFacets    b.circleOptsFacets
  }

instance IsOpts CircleOpts where
  getOpts opt =
    CircleOpts {
      circleOptsDiameter  = orDef 100   opt.circleOptsDiameter,
      circleOptsPlacement = orDef PlacementCenter opt.circleOptsPlacement,
      circleOptsFacets    = orDef 100     opt.circleOptsFacets
    }

instance HasDiameter (CircleOpts Maybe) where
  diameter v = mempty { circleOptsDiameter = Just v }

instance HasFacets (CircleOpts Maybe) where
  facets v = mempty { circleOptsFacets = Just v }

instance HasPlacement (CircleOpts Maybe) where
  placement v = mempty { circleOptsPlacement = Just v }


circle :: (MonadNeon m) => CircleOpts Maybe -> m Model2D
circle allOpts = do
  facets <- askFacets
  pure $ handlePlacement $ Primitive2D $ Circle2D
    { circleDiameter = get opts.circleOptsDiameter
    , circleFacets = Just facets
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

instance Monoid (EllipseOpts Maybe) where
  mempty = EllipseOpts {
    ellipseOptsSize = Nothing,
    ellipseOptsPlacement = Nothing
  }

instance Semigroup (EllipseOpts Maybe) where
  a <> b = EllipseOpts {
    ellipseOptsSize = mappendFirst a.ellipseOptsSize b.ellipseOptsSize,
    ellipseOptsPlacement = mappendFirst a.ellipseOptsPlacement b.ellipseOptsPlacement
  }

instance IsOpts EllipseOpts where
  getOpts opt = EllipseOpts {
    ellipseOptsSize = orDef (100, 100) opt.ellipseOptsSize,
    ellipseOptsPlacement = orDef PlacementCenter opt.ellipseOptsPlacement
  }

ellipse :: MonadNeon m => EllipseOpts Maybe -> m Model2D
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

instance Semigroup (RectOpts Maybe) where
  a <> b = RectOpts {
    rectOptsSize      = mappendFirst a.rectOptsSize       b.rectOptsSize,
    rectOptsPlacement = mappendFirst a.rectOptsPlacement b.rectOptsPlacement
  }

instance Monoid (RectOpts Maybe) where
  mempty = RectOpts {
    rectOptsSize      = Nothing,
    rectOptsPlacement = Nothing
  }

instance IsOpts RectOpts where
  getOpts opt = RectOpts {
    rectOptsSize      = orDef (100, 100) opt.rectOptsSize,
    rectOptsPlacement = orDef PlacementCenter opt.rectOptsPlacement
  }

instance HasPlacement (RectOpts Maybe) where
  placement v = mempty { rectOptsPlacement = Just v }

instance HasSize (V2 Double) (RectOpts Maybe) where
  size v = mempty { rectOptsSize = Just v }

rect :: MonadNeon m => RectOpts Maybe -> m Model2D
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

instance Semigroup (SquareOpts Maybe) where
  a <> b = SquareOpts {
    squareOptsSize = mappendFirst a.squareOptsSize b.squareOptsSize,
    squareOptsPlacement = mappendFirst a.squareOptsPlacement b.squareOptsPlacement
  }

instance Monoid (SquareOpts Maybe) where
  mempty = SquareOpts {
    squareOptsSize = Nothing,
    squareOptsPlacement = Nothing
  }

instance IsOpts SquareOpts where
  getOpts opt = SquareOpts {
    squareOptsSize = orDef 100 opt.squareOptsSize,
    squareOptsPlacement = orDef PlacementCenter opt.squareOptsPlacement
  }

instance HasSize Double (SquareOpts Maybe) where
  size v = mempty { squareOptsSize = Just v }

instance HasPlacement (SquareOpts Maybe) where
  placement v = mempty { squareOptsPlacement = Just v }

square :: MonadNeon m => SquareOpts Maybe -> m Model2D
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

instance Monoid (PolygonOpts Maybe) where
  mempty = PolygonOpts {
    polygonOptsPoints = Nothing,
    polygonOptsConvexity = Nothing,
    polygonOptsPlacement = Nothing
  }

instance Semigroup (PolygonOpts Maybe) where
  a <> b = PolygonOpts {
    polygonOptsPoints = mappendFirst a.polygonOptsPoints b.polygonOptsPoints,
    polygonOptsConvexity = mappendFirst a.polygonOptsConvexity b.polygonOptsConvexity,
    polygonOptsPlacement = mappendFirst a.polygonOptsPlacement b.polygonOptsPlacement
  }

instance IsOpts PolygonOpts where
  getOpts opt = PolygonOpts {
    polygonOptsPoints = orDef [(0, 0), (100, 0), (100, 100), (0, 100)] opt.polygonOptsPoints,
    polygonOptsConvexity = orDef defaultConvexity opt.polygonOptsConvexity,
    polygonOptsPlacement = orDef PlacementCenter opt.polygonOptsPlacement
  }


defaultConvexity :: Int
defaultConvexity = 10

polygon :: MonadNeon m => PolygonOpts Maybe -> m Model2D
polygon optsMay = undefined -- TODO: Implement
  where
    opts = getOpts optsMay

-------------------------------------------------------------------------------
-- / 2D / Primitive / Text
-------------------------------------------------------------------------------

data TextOpts = TextOpts {
  textFont      :: FontName,
  textSize      :: Double,
  textStyle     :: FontStyle,
  textDirection :: Direction,
  textHAlign    :: HorizontalAlignment,
  textVAlign    :: VerticalAlignment,
  textSpacing   :: Double
}

defaultTextOpts :: TextOpts
defaultTextOpts = TextOpts {
  textFont      = FNLiberationSans,
  textSize      = 10,
  textStyle     = FSRegular,
  textDirection = LeftToRight,
  textHAlign    = HALeft,
  textVAlign    = VABaseline,
  textSpacing   = 1
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

textWith :: MonadNeon m => String -> TextOpts -> m Model2D
textWith txt opts = do
  facets <- askFacets
  pure $ Primitive2D $ Text2D
    { textText      = txt
    , textSize      = spareOpt opts.textSize defaultTextOpts.textSize
    , textFont      = mkFont
       (spareOpt opts.textFont defaultTextOpts.textFont)
       (spareOpt opts.textStyle defaultTextOpts.textStyle)
    , textDirection = spareOpt opts.textDirection defaultTextOpts.textDirection
    , textLanguage  = Nothing
    , textScript    = Nothing
    , textHAlign    = spareOpt opts.textHAlign defaultTextOpts.textHAlign
    , textVAlign    = spareOpt opts.textVAlign defaultTextOpts.textVAlign
    , textSpacing   = spareOpt opts.textSpacing defaultTextOpts.textSpacing
    , textEm        = Nothing
    , textFacets    = Just facets
    }

text :: MonadNeon m => String -> m Model2D
text txt = textWith txt defaultTextOpts

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

box :: MonadNeon m => V3 Double -> m Model3D
box size = pure $ Primitive3D $ Cube3D
  { cubeSize = size
  , cubeCenter = Nothing
  }

boxCenter :: MonadNeon m => V3 Double -> m Model3D
boxCenter size = pure $ Primitive3D $ Cube3D
  { cubeSize = size
  , cubeCenter = Just True
  }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cube
-------------------------------------------------------------------------------

cube :: MonadNeon m => Double -> m Model3D
cube size = pure $ Primitive3D $ Cube3D
  { cubeSize = (size, size, size)
  , cubeCenter = Nothing
  }

cubeCenter :: MonadNeon m => Double -> m Model3D
cubeCenter size = pure $ Primitive3D $ Cube3D
  { cubeSize = (size, size, size)
  , cubeCenter = Just True
  }

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

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Primitive / Ellipsoid
-------------------------------------------------------------------------------

-- TODO: Implement

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

orDef :: a -> Maybe a -> Identity a
orDef def may = pure $ fromMaybe def may

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