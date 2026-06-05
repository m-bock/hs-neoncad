{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use <$>" #-}

{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE NoFieldSelectors #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE StandaloneDeriving #-}


module NeonCAD (
  -- * Basic
  run,
  render2D, render3D,
  MonadNeon,

  -- * 3D Primitives
  -- ** Box
  -- |
  -- ![box](out/doc-imgs/box.png)
  --
  box, BoxOpts,

  -- ** Cube
  -- |
  -- ![cube](out/doc-imgs/cube.png)
  cube, CubeOpts,

  -- ** Sphere
  -- |
  -- ![sphere](out/doc-imgs/sphere.png)
  sphere, SphereOpts,

  -- ** Ellipsoid
  -- |
  -- ![ellipsoid](out/doc-imgs/ellipsoid.png)
  ellipsoid, EllipsoidOpts,

  -- ** Cylinder
  -- |
  -- ![cylinder](out/doc-imgs/cylinder.png)
  cylinder, CylinderOpts,

  -- ** Polyhedron
  -- |
  -- ![polyhedron](out/doc-imgs/polyhedron.png)
  polyhedron, PolyhedronOpts,

  -- * 2D Primitives
  -- ** Text
  -- |
  -- ![text](out/doc-imgs/text.png)
  text, TextOpts,

  -- ** Rect
  -- |
  -- ![rect](out/doc-imgs/rect.png)
  rect, RectOpts,

  -- ** Square
  -- |
  -- ![square](out/doc-imgs/square.png)
  square, SquareOpts,

  -- ** Polygon
  -- |
  -- ![polygon](out/doc-imgs/polygon.png)
  polygon, PolygonOpts,

  -- ** Ellipse
  -- |
  -- ![ellipse](out/doc-imgs/ellipse.png)
  ellipse, EllipseOpts,

  -- ** Circle
  -- |
  -- ![circle](out/doc-imgs/circle.png)
  circle, CircleOpts,

  -- * Attributes
  -- |
  HasSize(..),
  HasPlacement(..),
  HasFacets(..),
  HasDiameter(..),
  HasFaces(..),
  HasConvexity(..),
  HasPoints(..),
  HasHeight(..),

  -- * Facts
  IsCenter(..),
  IsOrigin(..),
  IsLeft(..),
  IsRight(..),

  -- * Modifiers
  -- ** Move
  CanMoveXYZ(..),
  CanMoveXY(..),
  CanMoveXZ(..),
  CanMoveYZ(..),
  CanMoveX(..),
  CanMoveY(..),
  CanMoveZ(..),

  -- ** Scale
  CanScaleXYZ(..),
  CanScaleXY(..),
  CanScaleXZ(..),
  CanScaleYZ(..),
  CanScaleX(..),
  CanScaleY(..),
  CanScaleZ(..),
  CanScale(..),

  -- ** Resize
  CanResizeXYZ(..),
  CanResizeXY(..),
  CanResizeXZ(..),
  CanResizeYZ(..),
  CanResizeX(..),
  CanResizeY(..),
  CanResizeZ(..),
  CanResizeAutoXY(..),
  CanResizeAutoXZ(..),
  CanResizeAutoYZ(..),
  CanResizeAutoX(..),
  CanResizeAutoY(..),
  CanResizeAutoZ(..),

  -- ** Spin
  CanSpinXYZ(..),
  CanSpinXY(..),
  CanSpinXZ(..),
  CanSpinYZ(..),
  CanSpinX(..),
  CanSpinY(..),
  CanSpinZ(..),

  -- ** Mirror
  CanMirrorXYZ(..),
  CanMirrorXY(..),
  CanMirrorXZ(..),
  CanMirrorYZ(..),
  CanMirrorX(..),
  CanMirrorY(..),
  CanMirrorZ(..),

  -- ** Comment
  CanComment(..),
  

  -- * Models
  Model2D, Model3D,

  -- comment,
  -- render2D, render3D,

  -- diameter, radius,
  -- facets,
  -- center, origin,
  -- scale, scaleXYZ, scaleXY, scaleXZ, scaleYZ, scaleX, scaleY, scaleZ,
  -- size,
  -- HasSize, HasPlacement,
  -- height,
  -- centerZ,

  -- -- 2D / Primitive
  -- ellipse,
  -- circle,
  -- rect,
  -- square,
  -- polygon, points, convexity,
  -- text, str, TextOpts, FontName, FontStyle, fontName, fontStyle, fontSize, direction, hAlign, vAlign, fontSpacing,

  -- offset,

  -- -- 3D / Primitive
  -- box,
  -- cube,
  -- sphere,
  -- ellipsoid,
  -- cylinder,
  -- polyhedron,

  -- empty,

  -- left, right,

  -- -- Transform
  -- union, unions,
  -- intersection, intersections,
  -- difference,
  -- resizeXYZ, resizeXY, resizeXZ, resizeYZ, resizeX, resizeY, resizeZ,
  -- resizeAutoXY, resizeAutoXZ, resizeAutoYZ, resizeAutoX, resizeAutoY, resizeAutoZ,
  -- moveXYZ, moveXY, moveXZ, moveYZ, moveX, moveY, moveZ,
  -- spinXYZ, spinXY, spinXZ, spinYZ, spinX, spinY, spinZ,
  -- mirrorXYZ, mirrorXY, mirrorXZ, mirrorYZ, mirrorX, mirrorY, mirrorZ,
  -- color, rgb, alpha, Color,
  -- hull,

  -- -- 2D-3D Conversion
  -- extrudeLinear, extrudeRotational,

  -- -- Modifiers
  -- modDisable, modShowOnly, modHighlight, modTransparent,

  -- runNeonM, runNeonT,
  -- fn, fa, fs, defaultFacets,
  -- askFacets, localFacets,
  -- Model2D, Model3D, V2, V3, Facets,
  -- MonadNeon, diameterTop, diameterBottom, frustum, scaleFactor, twistAngle, twistSlices, twistSlicesAuto, faces

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

import Prelude hiding (undefined)
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
defaultPolygonPoints = map (\(x, y) -> (x * l, y * l))
  [ ( 0,  1)
  , ( 1,  1)
  , ( 1,  0)
  , ( 0, -1)
  , (-1, -1)
  , (-1,  0)
  ]
  where
    l = sqrt (defaultArea / 3)


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


defaultPolyhedronPoints :: [V3 Double]
defaultPolyhedronPoints = map (\(x, y, z) -> (x * 70, y * 70, z * 50))
  [ (  0, -1, -1)
  , ( -1,  0, -1)
  , (  1,  0, -1)
  , (  1,  0,  1)
  , (  0,  1,  1)
  , ( -1,  0,  1)
  ]

defaultPolyhedronFaces :: [V3 Int]
defaultPolyhedronFaces = 
  [ (0, 1, 2), (3, 5, 4), (0, 1, 5), (0, 2, 3), (3, 5, 0), (2, 1, 4), (1, 5, 4), (2, 3, 4) ]

-------------------------------------------------------------------------------
-- / Monad
-------------------------------------------------------------------------------

newtype NeonT m a = NeonT (Facets -> m a)
  deriving (Functor)

type NeonM = NeonT Identity

runNeonT :: Facets -> NeonT m a -> m a
runNeonT factes (NeonT f) = f factes

runNeonM :: Facets -> NeonM a -> a
runNeonM fcs neon = get $ runNeonT fcs neon

run :: NeonM a -> a
run neon = runNeonM defaultFacets neon

instance (Monad m) => Applicative (NeonT m) where
  pure x = NeonT $ \_ -> pure x
  f <*> v = NeonT $ \ r -> runNeonT r f <*> runNeonT r v

instance (Monad m) => Monad (NeonT m) where
  return = pure
  a >>= f = NeonT $ \ r -> runNeonT r a >>= \b -> runNeonT r (f b)

instance Monad m => MonadNeon (NeonT m) where
  askFacets = NeonT pure
  localFacets fcs m = NeonT $ \_ -> runNeonT fcs m

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
-- / Facts
-------------------------------------------------------------------------------

class IsLeft a where
  left :: a

instance IsLeft HorizontalAlignment where
  left = HALeft

class IsRight a where
  right :: a

instance IsRight HorizontalAlignment where
  right = HARight

class IsCenter a where
  center :: a

instance IsCenter HorizontalAlignment where
  center = HACenter

-------------------------------------------------------------------------------
-- / Classes
-------------------------------------------------------------------------------

class (Monad m) => MonadNeon m where
  askFacets :: m Facets
  localFacets :: Facets -> m a -> m a

-------------------------------------------------------------------------------
-- / Classes / HasPlacement
-------------------------------------------------------------------------------

data Placement = PlacementCenter | PlacementOrigin

class HasPlacement a where
  placement :: Placement -> a


-------------------------------------------------------------------------------
-- / Classes / IsOrigin
-------------------------------------------------------------------------------

class IsOrigin a where
  origin :: a

instance IsOrigin Placement where
  origin = PlacementOrigin

-------------------------------------------------------------------------------
-- / Classes / IsCenter
-------------------------------------------------------------------------------

instance IsCenter Placement where
  center = PlacementCenter

-------------------------------------------------------------------------------
-- / Classes / HasHeight
-------------------------------------------------------------------------------

class HasHeight a where
  height :: Double -> a

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
-- / Classes / HasPoints
-------------------------------------------------------------------------------

class HasPoints v a | a -> v where
  points :: v -> a

-------------------------------------------------------------------------------
-- / Classes / HasSize
-------------------------------------------------------------------------------

-- | A
class HasSize v a | a -> v where
  -- | B
  size :: v -> a

-------------------------------------------------------------------------------
-- / Classes / HasFaces
-------------------------------------------------------------------------------

class HasFaces v a | a -> v where
  faces :: v -> a

-------------------------------------------------------------------------------
-- / Classes / HasConvexity
-------------------------------------------------------------------------------

class HasConvexity a where
  convexity :: Int -> a

-------------------------------------------------------------------------------
-- / Classes / Comment
-------------------------------------------------------------------------------

class CanComment a where
  comment :: String -> a -> a

instance MonadNeon m => CanComment (m Model2D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment2D txt model

instance MonadNeon m => CanComment (m Model3D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment3D txt model

-------------------------------------------------------------------------------
-- / Classes / CanScale
-------------------------------------------------------------------------------

class CanScaleXYZ a where
  scaleXYZ :: V3 Double -> a -> a

class CanScaleXY a where
  scaleXY :: V2 Double -> a -> a

class CanScaleXZ a where
  scaleXZ :: V2 Double -> a -> a

class CanScaleYZ a where
  scaleYZ :: V2 Double -> a -> a

class CanScaleX a where
  scaleX :: Double -> a -> a

class CanScaleY a where
  scaleY :: Double -> a -> a

class CanScaleZ a where
  scaleZ :: Double -> a -> a

class CanScale a where
  scale :: Double -> a -> a

-- * 2D

instance (MonadNeon m) => CanScaleXY (m Model2D) where
  scaleXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Scale2D (x, y)) [model]

instance (MonadNeon m) => CanScaleX (m Model2D) where
  scaleX x modelM = scaleXY (x, 1) modelM

instance (MonadNeon m) => CanScaleY (m Model2D) where
  scaleY y modelM = scaleXY (1, y) modelM

instance MonadNeon m => CanScale (m Model2D) where
  scale x modelM = scaleXY (x, x) modelM

-- * 3D

instance (MonadNeon m) => CanScaleXYZ (m Model3D) where
  scaleXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Scale3D v) [model]

instance (MonadNeon m) => CanScaleXY (m Model3D) where
  scaleXY (x, y) modelM = scaleXYZ (x, y, 1) modelM
  
instance (MonadNeon m) => CanScaleXZ (m Model3D) where
  scaleXZ (x, z) modelM = scaleXYZ (x, 1, z) modelM

instance (MonadNeon m) => CanScaleYZ (m Model3D) where
  scaleYZ (y, z) modelM = scaleXYZ (1, y, z) modelM

instance (MonadNeon m) => CanScaleX (m Model3D) where
  scaleX x modelM = scaleXYZ (x, 1, 1) modelM

instance (MonadNeon m) => CanScaleY (m Model3D) where
  scaleY y modelM = scaleXYZ (1, y, 1) modelM

instance MonadNeon m => CanScale (m Model3D) where
  scale x modelM = scaleXYZ (x, x, x) modelM

-------------------------------------------------------------------------------
-- / Modifiers / CanMove
-------------------------------------------------------------------------------

class CanMoveXYZ a where
  moveXYZ :: V3 Double -> a -> a

class CanMoveXY a where
  moveXY :: V2 Double -> a -> a

class CanMoveXZ a where
  moveXZ :: V2 Double -> a -> a

class CanMoveYZ a where
  moveYZ :: V2 Double -> a -> a

class CanMoveX a where
  moveX :: Double -> a -> a

class CanMoveY a where
  moveY :: Double -> a -> a

class CanMoveZ a where
  moveZ :: Double -> a -> a

-- * 2D

instance (MonadNeon m) => CanMoveXY (m Model2D) where
  moveXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (x, y, 0)) [model]

instance (MonadNeon m) => CanMoveX (m Model2D) where
  moveX x modelM = moveXY (x, 0) modelM

instance (MonadNeon m) => CanMoveY (m Model2D) where
  moveY y modelM = moveXY (0, y) modelM

instance (MonadNeon m) => CanMoveZ (m Model2D) where
  moveZ z modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (0, 0, z)) [model]


-- * 3D

instance (MonadNeon m) => CanMoveXYZ (m Model3D) where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Translate3D v) [model]

instance (MonadNeon m) => CanMoveXY (m Model3D) where
  moveXY (x, y) modelM = moveXYZ (x, y, 0) modelM

instance (MonadNeon m) => CanMoveXZ (m Model3D) where
  moveXZ (x, z) modelM = moveXYZ (x, 0, z) modelM

instance (MonadNeon m) => CanMoveYZ (m Model3D) where
  moveYZ (y, z) modelM = moveXYZ (0, y, z) modelM

instance (MonadNeon m) => CanMoveX (m Model3D) where
  moveX x modelM = moveXYZ (x, 0, 0) modelM

instance (MonadNeon m) => CanMoveY (m Model3D) where
  moveY y modelM = moveXYZ (0, y, 0) modelM

instance (MonadNeon m) => CanMoveZ (m Model3D) where
  moveZ z modelM = moveXYZ (0, 0, z) modelM


-------------------------------------------------------------------------------
-- / Classes / CanResize
-------------------------------------------------------------------------------

class CanResizeXYZ a where
  resizeXYZ :: V3 Double -> a -> a

class CanResizeXY a where
  resizeXY :: V2 Double -> a -> a

class CanResizeXZ a where
  resizeXZ :: V2 Double -> a -> a

class CanResizeYZ a where
  resizeYZ :: V2 Double -> a -> a

class CanResizeX a where
  resizeX :: Double -> a -> a

class CanResizeY a where
  resizeY :: Double -> a -> a

class CanResizeZ a where
  resizeZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => CanResizeXY (m Model2D) where
  resizeXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, y) Nothing) [model]
    
    
instance (MonadNeon m) => CanResizeX (m Model2D) where
  resizeX x modelM = resizeXY (x, 1) modelM

instance (MonadNeon m) => CanResizeY (m Model2D) where
  resizeY y modelM = resizeXY (1, y) modelM


-- * 3D

instance (MonadNeon m) => CanResizeXYZ (m Model3D) where
  resizeXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, z) Nothing) [model]
    
instance (MonadNeon m) => CanResizeXY (m Model3D) where
  resizeXY (x, y) modelM = resizeXYZ (x, y, 0) modelM
  
instance (MonadNeon m) => CanResizeXZ (m Model3D) where
  resizeXZ (x, z) modelM = resizeXYZ (x, 1, z) modelM

instance (MonadNeon m) => CanResizeYZ (m Model3D) where
  resizeYZ (y, z) modelM = resizeXYZ (1, y, z) modelM

instance (MonadNeon m) => CanResizeX (m Model3D) where
  resizeX x modelM = resizeXYZ (x, 1, 1) modelM

instance (MonadNeon m) => CanResizeY (m Model3D) where
  resizeY y modelM = resizeXYZ (1, y, 1) modelM

instance (MonadNeon m) => CanResizeZ (m Model3D) where
  resizeZ z modelM = resizeXYZ (1, 1, z) modelM

-------------------------------------------------------------------------------
-- / Classes / CanResize Auto
-------------------------------------------------------------------------------

class CanResizeAutoXY a where
  resizeAutoXY :: V2 Double -> a -> a

class CanResizeAutoXZ a where
  resizeAutoXZ :: V2 Double -> a -> a

class CanResizeAutoYZ a where
  resizeAutoYZ :: V2 Double -> a -> a

class CanResizeAutoX a where
  resizeAutoX :: Double -> a -> a

class CanResizeAutoY a where
  resizeAutoY :: Double -> a -> a

class CanResizeAutoZ a where
  resizeAutoZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => CanResizeAutoX (m Model2D) where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, 0) (Just (False, True))) [model]

instance (MonadNeon m) => CanResizeAutoY (m Model2D) where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (0, y) (Just (True, False))) [model]


-- * 3D

instance (MonadNeon m) => CanResizeAutoXY (m Model3D) where
  resizeAutoXY (x, y) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, 0) (Just (False, False, True))) [model]
  
instance (MonadNeon m) => CanResizeAutoXZ (m Model3D) where
  resizeAutoXZ (x, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, z) (Just (False, True, False))) [model]
  
instance (MonadNeon m) => CanResizeAutoYZ (m Model3D) where
  resizeAutoYZ (y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, z) (Just (True, False, False))) [model]

instance (MonadNeon m) => CanResizeAutoX (m Model3D) where
  resizeAutoX x modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, 0) (Just (False, True, True))) [model]

instance (MonadNeon m) => CanResizeAutoY (m Model3D) where
  resizeAutoY y modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, y, 0) (Just (True, False, True))) [model]

instance (MonadNeon m) => CanResizeAutoZ (m Model3D) where
  resizeAutoZ z modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (0, 0, z) (Just (True, True, False))) [model]


-------------------------------------------------------------------------------
-- / Classes / CanSpin
-------------------------------------------------------------------------------

class CanSpinXYZ a where
  spinXYZ :: V3 Double -> a -> a

class CanSpinXY a where
  spinXY :: V2 Double -> a -> a

class CanSpinXZ a where
  spinXZ :: V2 Double -> a -> a

class CanSpinYZ a where
  spinYZ :: V2 Double -> a -> a

class CanSpinX a where
  spinX :: Double -> a -> a

class CanSpinY a where
  spinY :: Double -> a -> a

class CanSpinZ a where
  spinZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => CanSpinZ (m Model2D) where
  spinZ z modelM = do
    model <- modelM
    pure $ Transform2D (RotateEuler2D (0, 0, z)) [model]


-- * 3D

instance (MonadNeon m) => CanSpinXYZ (m Model3D) where
  spinXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (RotateEuler3D (x, y, z)) [model]

instance (MonadNeon m) => CanSpinXY (m Model3D) where
  spinXY (x, y) modelM = spinXYZ (x, y, 0) modelM

instance (MonadNeon m) => CanSpinXZ (m Model3D) where
  spinXZ (x, z) modelM = spinXYZ (x, 0, z) modelM

instance (MonadNeon m) => CanSpinYZ (m Model3D) where
  spinYZ (y, z) modelM = spinXYZ (0, y, z) modelM

instance (MonadNeon m) => CanSpinX (m Model3D) where
  spinX x modelM = spinXYZ (x, 0, 0) modelM

instance (MonadNeon m) => CanSpinY (m Model3D) where
  spinY y modelM = spinXYZ (0, y, 0) modelM

instance (MonadNeon m) => CanSpinZ (m Model3D) where
  spinZ z modelM = spinXYZ (0, 0, z) modelM

-------------------------------------------------------------------------------
-- / Classes / CanMirror
-------------------------------------------------------------------------------

class CanMirrorXYZ a where
  mirrorXYZ :: V3 Double -> a -> a

class CanMirrorXY a where
  mirrorXY :: V2 Double -> a -> a

class CanMirrorXZ a where
  mirrorXZ :: V2 Double -> a -> a

class CanMirrorYZ a where
  mirrorYZ :: V2 Double -> a -> a

class CanMirrorX a where
  mirrorX :: a -> a

class CanMirrorY a where
  mirrorY :: a -> a

class CanMirrorZ a where
  mirrorZ :: Double -> a -> a


-- * 2D

instance (MonadNeon m) => CanMirrorX (m Model2D) where
  mirrorX modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (0, 1)) [model]


instance (MonadNeon m) => CanMirrorY (m Model2D) where
  mirrorY modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (1, 0)) [model]

instance (MonadNeon m) => CanMirrorXY (m Model2D) where
  mirrorXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (x, y)) [model]

-- * 3D

instance (MonadNeon m) => CanMirrorXYZ (m Model3D) where
  mirrorXYZ (x, y, z) modelM = do
    model <- modelM
    pure $ Transform3D (Mirror3D (x, y, z)) [model]

instance (MonadNeon m) => CanMirrorXY (m Model3D) where
  mirrorXY (x, y) modelM = mirrorXYZ (x, y, 0) modelM

instance (MonadNeon m) => CanMirrorXZ (m Model3D) where
  mirrorXZ (x, z) modelM = mirrorXYZ (x, 0, z) modelM

instance (MonadNeon m) => CanMirrorYZ (m Model3D) where
  mirrorYZ (y, z) modelM = mirrorXYZ (0, y, z) modelM

instance (MonadNeon m) => CanMirrorX (m Model3D) where
  mirrorX modelM = mirrorXYZ (1, 0, 0) modelM

instance (MonadNeon m) => CanMirrorY (m Model3D) where
  mirrorY modelM = mirrorXYZ (0, 1, 0) modelM

instance (MonadNeon m) => CanMirrorZ (m Model3D) where
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

  intersections modelsM = do
    models <- sequence modelsM
    pure $ BoolOp3D Intersection3D models

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

instance IsCenter (CircleOpts First) where
  center = mempty { circleOptsPlacement = First $ Just PlacementCenter }

circle :: (MonadNeon m) => CircleOpts First -> m Model2D
circle allOpts = do
  fc <- askFacets
  
  let
    opts :: CircleOpts Identity
    opts = bzipWith orDef (fallbackCircleOpts fc) allOpts

    r = get opts.circleOptsDiameter / 2

    handlePlacement m = case get opts.circleOptsPlacement of
      PlacementCenter -> m
      PlacementOrigin -> moveXY (r, r) m

  handlePlacement $ pure $ Primitive2D $ Circle2D
    { circleDiameter = get opts.circleOptsDiameter
    , circleFacets   = Just (get opts.circleOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 2D / Primitive / Ellipse
-------------------------------------------------------------------------------

data EllipseOpts f = EllipseOpts {
  ellipseOptsSize      :: f (V2 Double),
  ellipseOptsPlacement :: f Placement,
  ellipseOptsFacets    :: f Facets
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
  ellipseOptsFacets    = pure fc
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
      PlacementOrigin -> moveXY (dx, dy) m

  handlePlacement $
    resizeXY (dx, dy) $
      circle (diameter (max dx dy) <> facets (get opts.ellipseOptsFacets))

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

instance IsCenter (RectOpts First) where
  center = mempty { rectOptsPlacement = First $ Just PlacementCenter }

rect :: MonadNeon m => RectOpts First -> m Model2D
rect opts = pure $ Primitive2D $ Square2D
  { squareSize = get opt.rectOptsSize
  , squareCenter = case get opt.rectOptsPlacement of
      PlacementCenter -> Just True
      PlacementOrigin -> Nothing
  }
  where
    opt :: RectOpts Identity
    opt = bzipWith orDef fallbackRectOpts opts

-------------------------------------------------------------------------------
-- / 2D / Primitive / Square
-------------------------------------------------------------------------------

data SquareOpts f = SquareOpts {
  squareOptsSize      :: f Double,
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

instance IsCenter (SquareOpts First) where
  center = mempty { squareOptsPlacement = First $ Just PlacementCenter }

fallbackSquareOpts :: SquareOpts Identity
fallbackSquareOpts = SquareOpts {
  squareOptsSize      = pure defaultSquareSize,
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
      PlacementOrigin -> Nothing
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
  polygonOptsPoints    :: f [V2 Double],
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

instance HasPoints [V2 Double] (PolygonOpts First) where
  points v = mempty { polygonOptsPoints = First $ Just v }

instance HasPlacement (PolygonOpts First) where
  placement v = mempty { polygonOptsPlacement = First $ Just v }

fallbackPolygonOpts :: PolygonOpts Identity
fallbackPolygonOpts = PolygonOpts {
  polygonOptsPoints    = pure defaultPolygonPoints,
  polygonOptsConvexity = pure defaultConvexity,
  polygonOptsPlacement = pure PlacementCenter
}

polygon :: MonadNeon m => PolygonOpts First -> m Model2D
polygon optsMay = pure $ Primitive2D $ Polygon2D
  { polygonPoints    = get opts.polygonOptsPoints
  , polygonConvexity = Just $ get opts.polygonOptsConvexity
  , polygonPaths     = Nothing
  }
  where
    opts :: PolygonOpts Identity
    opts = bzipWith orDef fallbackPolygonOpts optsMay

-------------------------------------------------------------------------------
-- / 2D / Primitive / Text
-------------------------------------------------------------------------------

class HasFontName a where
  fontName :: FontName -> a

class HasFontStyle a where
  fontStyle :: FontStyle -> a

class HasDirection a where
  direction :: Direction -> a

class HasHorizontalAlignment a where
  hAlign :: HorizontalAlignment -> a

class HasVerticalAlignment a where
  vAlign :: VerticalAlignment -> a

class HasSpacing a where
  spacing :: Double -> a

data TextOpts f = TextOpts {
  textOptsText      :: f String,
  textOptsFont      :: f FontName,
  textOptsSize      :: f Double,
  textOptsStyle     :: f FontStyle,
  textOptsDirection :: f Direction,
  textOptsHAlign    :: f HorizontalAlignment,
  textOptsVAlign    :: f VerticalAlignment,
  textOptsSpacing   :: f Double
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (TextOpts First)
  instance Semigroup (TextOpts First)

deriving via Generically (TextOpts First)
  instance Monoid (TextOpts First)

instance HasFontName (TextOpts First) where
  fontName n = mempty { textOptsFont = First $ Just n }
  
instance HasFontStyle (TextOpts First) where
  fontStyle s = mempty { textOptsStyle = First $ Just s }
  
instance HasDirection (TextOpts First) where
  direction dir = mempty { textOptsDirection = First $ Just dir }
  
instance HasHorizontalAlignment (TextOpts First) where
  hAlign ha = mempty { textOptsHAlign = First $ Just ha }

instance HasVerticalAlignment (TextOpts First) where
  vAlign va = mempty { textOptsVAlign = First $ Just va }
  
instance HasSpacing (TextOpts First) where
  spacing s = mempty { textOptsSpacing = First $ Just s }

fontSpacing :: Double -> TextOpts First
fontSpacing s = mempty { textOptsSpacing = First $ Just s }

str :: String -> TextOpts First
str s = mempty { textOptsText = First $ Just s }


fallbackTextOpts :: TextOpts Identity
fallbackTextOpts = TextOpts {
  textOptsText      = pure "Hello, World!",
  textOptsFont      = pure FNLiberationSans,
  textOptsSize      = pure 10,
  textOptsStyle     = pure FSRegular,
  textOptsDirection = pure LeftToRight,
  textOptsHAlign    = pure HALeft,
  textOptsVAlign    = pure VABaseline,
  textOptsSpacing   = pure 1
}

data FontName
  = FNLiberationMono
  | FNLiberationSans
  | FNLiberationSerif
  | FNCustom String
  deriving (Eq)

fontNameToString :: FontName -> String
fontNameToString = \case
  FNLiberationMono  -> "Liberation Mono"
  FNLiberationSans  -> "Liberation Sans"
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
mkFont fontNameMay style = case (fontNameMay, style) of
  (Nothing, Nothing) -> Nothing
  (Just n, mayStyle) -> Just $ Font
    { fontFamily = fontNameToString n
    , fontOptions = case mayStyle of
      Just s  -> [("style", fontStyleToString s)]
      Nothing -> []
    }
  (Nothing, mayStyle) -> mkFont (Just FNLiberationSans) mayStyle

text :: MonadNeon m => String -> TextOpts First -> m Model2D
text s optsMay = do
  fc <- askFacets
  pure $ Primitive2D $ Text2D
    { textText      = get opts.textOptsText
    , textSize      = fmap get $ spareOpt opts.textOptsSize 10
    , textFont      = mkFont
        (fmap get $ spareOpt opts.textOptsFont (pure FNLiberationSans))
        (fmap get $ spareOpt opts.textOptsStyle (pure FSRegular))
    , textDirection = fmap get $ spareOpt opts.textOptsDirection (pure LeftToRight)
    , textHAlign    = fmap get $ spareOpt opts.textOptsHAlign (pure HALeft)
    , textVAlign    = fmap get $ spareOpt opts.textOptsVAlign (pure VABaseline)
    , textSpacing   = fmap get $ spareOpt opts.textOptsSpacing (pure 1)
    , textEm        = Nothing
    , textFacets    = Just fc
    , textLanguage  = Nothing
    , textScript    = Nothing
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
    { offsetDeltaDelta   = d
    , offsetDeltaChamfer = Nothing
    }) [model]

-- TODO: Implement
-- offsetRound :: (MonadNeon m) => Double -> m Model2D -> m Model2D
-- offsetRound = undefined

-- TODO: Implement
-- offsetCut :: (MonadNeon m) => Double -> m Model2D -> m Model2D
-- offsetCut = undefined

-------------------------------------------------------------------------------
-- / 3D / Primitive / Box
-------------------------------------------------------------------------------

-- | Options for creating a box.
newtype BoxOpts = BoxOpts { unBoxOpts :: BoxOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data BoxOptsInternal f = BoxOptsInternal {
  boxOptsSize      :: f (V3 Double),
  boxOptsPlacement :: f Placement
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (BoxOptsInternal First)
  instance Semigroup (BoxOptsInternal First)

deriving via Generically (BoxOptsInternal  First)
  instance Monoid (BoxOptsInternal First)


fallbackBoxOpts :: BoxOptsInternal Identity
fallbackBoxOpts = BoxOptsInternal {
  boxOptsSize      = pure defaultBoxSize,
  boxOptsPlacement = pure PlacementCenter
}

instance HasSize (V3 Double) BoxOpts where
  size v = BoxOpts $ mempty { boxOptsSize = First $ Just v }

instance HasPlacement BoxOpts where
  placement v = BoxOpts $ mempty { boxOptsPlacement = First $ Just v }

-- | Create a box from given options.
box :: MonadNeon m => BoxOpts -> m Model3D
box (BoxOpts optsMay) = pure $ Primitive3D $ Cube3D
  { cubeSize = get opts.boxOptsSize
  , cubeCenter = case get opts.boxOptsPlacement of
      PlacementCenter -> Just True
      PlacementOrigin -> Nothing
  }
  where
    opts :: BoxOptsInternal Identity
    opts = bzipWith orDef fallbackBoxOpts optsMay

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cube
-------------------------------------------------------------------------------

newtype CubeOpts = CubeOpts { unCubeOpts :: CubeOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data CubeOptsInternal f = CubeOptsInternal {
  cubeOptsSize      :: f Double,
  cubeOptsPlacement :: f Placement
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (CubeOptsInternal First)
  instance Semigroup (CubeOptsInternal First)

deriving via Generically (CubeOptsInternal First)
  instance Monoid (CubeOptsInternal First)


fallbackCubeOpts :: CubeOptsInternal Identity
fallbackCubeOpts = CubeOptsInternal {
  cubeOptsSize      = pure defaultCubeSize,
  cubeOptsPlacement = pure PlacementCenter
}

instance HasSize Double CubeOpts where
  size v = CubeOpts $ mempty { cubeOptsSize = First $ Just v }

instance HasPlacement CubeOpts where
  placement v = CubeOpts $ mempty { cubeOptsPlacement = First $ Just v }

cube :: MonadNeon m => CubeOpts -> m Model3D
cube (CubeOpts optsMay) = pure $ Primitive3D $ Cube3D
  { cubeSize = (s, s, s)
  , cubeCenter = case get opts.cubeOptsPlacement of
      PlacementCenter -> Just True
      PlacementOrigin -> Nothing
  }
  where
    s = get opts.cubeOptsSize
    
    opts :: CubeOptsInternal Identity
    opts = bzipWith orDef fallbackCubeOpts optsMay


-------------------------------------------------------------------------------
-- / 3D / Primitive / Frustum
-------------------------------------------------------------------------------

data FrustumOpts f = FrustumOpts {
  frustumOptsHeight         :: f Double,
  frustumOptsDiameterTop    :: f Double,
  frustumOptsDiameterBottom :: f Double,
  frustumOptsPlacement      :: f Placement,
  frustumOptsFacets         :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (FrustumOpts First)
  instance Semigroup (FrustumOpts First)

deriving via Generically (FrustumOpts First)
  instance Monoid (FrustumOpts First)

instance HasHeight (FrustumOpts First) where
  height v = mempty { frustumOptsHeight = First $ Just v }

diameterTop :: Double -> FrustumOpts First
diameterTop d = mempty { frustumOptsDiameterTop = First $ Just d }

diameterBottom :: Double -> FrustumOpts First
diameterBottom d = mempty { frustumOptsDiameterBottom = First $ Just d }

instance HasPlacement (FrustumOpts First) where
  placement v = mempty { frustumOptsPlacement = First $ Just v }

instance HasFacets (FrustumOpts First) where
  facets v = mempty { frustumOptsFacets = First $ Just v }

defaultFrustumRadiusTop :: Double
defaultFrustumRadiusTop = (3 * defaultVolume / (2 * pi * (defaultRatio ^ (2 :: Integer)) * (1 + defaultRatio + defaultRatio ^ (2 :: Integer)))) ** (1/3)

defaultFrustumDiameterTop :: Double
defaultFrustumDiameterTop = defaultFrustumRadiusTop * 2

defaultFrustumRadiusBottom :: Double
defaultFrustumRadiusBottom = defaultFrustumRadiusTop * defaultRatio

defaultFrustumDiameterBottom :: Double
defaultFrustumDiameterBottom = defaultFrustumRadiusBottom * 2

defaultFrustumHeight :: Double
defaultFrustumHeight = defaultFrustumDiameterBottom * defaultRatio

fallbackFrustumOpts :: Facets -> FrustumOpts Identity
fallbackFrustumOpts fc = FrustumOpts {
  frustumOptsHeight         = pure defaultFrustumHeight,
  frustumOptsDiameterTop    = pure defaultFrustumDiameterTop,
  frustumOptsDiameterBottom = pure defaultFrustumDiameterBottom,
  frustumOptsPlacement      = pure PlacementCenter,
  frustumOptsFacets         = pure fc
}

frustum :: MonadNeon m => FrustumOpts First -> m Model3D
frustum optsMay = do
  fc <- askFacets
  let
    opts :: FrustumOpts Identity
    opts = bzipWith orDef (fallbackFrustumOpts fc) optsMay

  pure $ Primitive3D $ Cylinder3D
    { cylinderHeight    = get opts.frustumOptsHeight
    , cylinderCenter    = case get opts.frustumOptsPlacement of
        PlacementCenter -> Just True
        PlacementOrigin -> Nothing
    , cylinderDiameter1 = get opts.frustumOptsDiameterBottom
    , cylinderDiameter2 = get opts.frustumOptsDiameterTop
    , cylinderFacets    = Just (get opts.frustumOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Cylinder
-------------------------------------------------------------------------------

newtype CylinderOpts = CylinderOpts { unCylinderOpts :: CylinderOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data CylinderOptsInternal f = CylinderOptsInternal {
  cylinderOptsHeight    :: f Double,
  cylinderOptsDiameter  :: f Double,
  cylinderOptsPlacement :: f Placement,
  cylinderOptsFacets    :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (CylinderOptsInternal First)
  instance Semigroup (CylinderOptsInternal First)

deriving via Generically (CylinderOptsInternal First)
  instance Monoid (CylinderOptsInternal First)

instance HasHeight CylinderOpts where
  height v = CylinderOpts $ mempty { cylinderOptsHeight = First $ Just v }

instance HasDiameter CylinderOpts where
  diameter v = CylinderOpts $ mempty { cylinderOptsDiameter = First $ Just v }

instance HasPlacement CylinderOpts where
  placement v = CylinderOpts $ mempty { cylinderOptsPlacement = First $ Just v }

instance HasFacets CylinderOpts where
  facets v = CylinderOpts $ mempty { cylinderOptsFacets = First $ Just v }

fallbackCylinderOpts :: Facets -> CylinderOptsInternal Identity
fallbackCylinderOpts fc = CylinderOptsInternal {
  cylinderOptsHeight    = pure defaultCylinderHeight,
  cylinderOptsDiameter  = pure defaultCylinderDiameter,
  cylinderOptsPlacement = pure PlacementCenter,
  cylinderOptsFacets    = pure fc
}

cylinder :: MonadNeon m => CylinderOpts -> m Model3D
cylinder (CylinderOpts optsMay) = do
  fc <- askFacets
  let
    opts :: CylinderOptsInternal Identity
    opts = bzipWith orDef (fallbackCylinderOpts fc) optsMay
  
    dia = get opts.cylinderOptsDiameter
  pure $ Primitive3D $ Cylinder3D
    { cylinderHeight = get opts.cylinderOptsHeight
    , cylinderCenter = case get opts.cylinderOptsPlacement of
      PlacementCenter -> Just True
      PlacementOrigin -> Nothing
    , cylinderDiameter1 = dia
    , cylinderDiameter2 = dia
    , cylinderFacets = Just (get opts.cylinderOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Sphere
-------------------------------------------------------------------------------

newtype SphereOpts = SphereOpts { unSphereOpts :: SphereOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data SphereOptsInternal f = SphereOptsInternal {
  sphereOptsDiameter  :: f Double,
  sphereOptsPlacement :: f Placement,
  sphereOptsFacets    :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (SphereOptsInternal First)
  instance Semigroup (SphereOptsInternal First)

deriving via Generically (SphereOptsInternal First)
  instance Monoid (SphereOptsInternal First)


fallbackSphereOpts :: Facets -> SphereOptsInternal Identity
fallbackSphereOpts fc = SphereOptsInternal {
  sphereOptsDiameter = pure defaultSphereDiameter,
  sphereOptsPlacement = pure PlacementCenter,
  sphereOptsFacets = pure fc
}

instance HasDiameter SphereOpts where
  diameter v = SphereOpts $ mempty { sphereOptsDiameter = First $ Just v }

instance HasPlacement SphereOpts where
  placement v = SphereOpts $ mempty { sphereOptsPlacement = First $ Just v }

instance HasFacets SphereOpts where
  facets v = SphereOpts $ mempty { sphereOptsFacets = First $ Just v }

sphere :: MonadNeon m => SphereOpts -> m Model3D
sphere (SphereOpts optsMay) = do
  fc <- askFacets
  let
    opts :: SphereOptsInternal Identity
    opts = bzipWith orDef (fallbackSphereOpts fc) optsMay

    d = get opts.sphereOptsDiameter
    r = d / 2

    handlePlacement m = case get opts.sphereOptsPlacement of
      PlacementCenter -> m
      PlacementOrigin -> moveXYZ (r, r, r) m

  handlePlacement $ pure $ Primitive3D $ Sphere3D
    { sphereDiameter = d
    , sphereFacets   = Just (get opts.sphereOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Ellipsoid
-------------------------------------------------------------------------------

newtype EllipsoidOpts = EllipsoidOpts { unEllipsoidOpts :: EllipsoidOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data EllipsoidOptsInternal f = EllipsoidOptsInternal {
  ellipsoidOptsSize :: f (V3 Double),
  ellipsoidOptsPlacement :: f Placement,
  ellipsoidOptsFacets :: f Facets
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (EllipsoidOptsInternal First)
  instance Semigroup (EllipsoidOptsInternal First)
  
deriving via Generically (EllipsoidOptsInternal First)
  instance Monoid (EllipsoidOptsInternal First)

fallbackEllipsoidOpts :: Facets -> EllipsoidOptsInternal Identity
fallbackEllipsoidOpts fc = EllipsoidOptsInternal {
  ellipsoidOptsSize = pure defaultEllipsoidSize,
  ellipsoidOptsPlacement = pure PlacementCenter,
  ellipsoidOptsFacets = pure fc
}

instance HasSize (V3 Double) EllipsoidOpts where
  size v = EllipsoidOpts $ mempty { ellipsoidOptsSize = First $ Just v }

instance HasPlacement EllipsoidOpts where
  placement v = EllipsoidOpts $ mempty { ellipsoidOptsPlacement = First $ Just v }

instance HasFacets EllipsoidOpts where
  facets v = EllipsoidOpts $ mempty { ellipsoidOptsFacets = First $ Just v }

ellipsoid :: MonadNeon m => EllipsoidOpts -> m Model3D
ellipsoid (EllipsoidOpts optsMay) = do
  fc <- askFacets
  let
    opts :: EllipsoidOptsInternal Identity
    opts = bzipWith orDef (fallbackEllipsoidOpts fc) optsMay

    (dx, dy, dz) = get opts.ellipsoidOptsSize
    dmax = max (max dx dy) dz
    
    handlePlacement m = case get opts.ellipsoidOptsPlacement of
      PlacementCenter -> m
      PlacementOrigin -> moveXYZ (dx, dy, dz) m

  handlePlacement $ resizeXYZ (dx, dy, dz) $ pure $ Primitive3D $ Sphere3D
    { sphereDiameter = dmax
    , sphereFacets = Just (get opts.ellipsoidOptsFacets)
    }

-------------------------------------------------------------------------------
-- / 3D / Primitive / Polyhedron
-------------------------------------------------------------------------------

newtype PolyhedronOpts = PolyhedronOpts { unPolyhedronOpts :: PolyhedronOptsInternal First }
  deriving newtype (Semigroup, Monoid)

data PolyhedronOptsInternal f = PolyhedronOptsInternal {
  polyhedronOptsPoints :: f [V3 Double],
  polyhedronOptsFaces  :: f [V3 Int],
  polyhedronOptsConvexity :: f Int
} 
  deriving
    ( Generic
    , FunctorB, TraversableB, ApplicativeB, ConstraintsB
    )

deriving via Generically (PolyhedronOptsInternal First)
  instance Semigroup (PolyhedronOptsInternal First)

deriving via Generically (PolyhedronOptsInternal First)
  instance Monoid (PolyhedronOptsInternal First)

instance HasPoints [V3 Double] PolyhedronOpts where
  points v = PolyhedronOpts $ mempty { polyhedronOptsPoints = First $ Just v }

instance HasFaces [V3 Int] PolyhedronOpts where
  faces v = PolyhedronOpts $ mempty { polyhedronOptsFaces = First $ Just v }

instance HasConvexity PolyhedronOpts where
  convexity v = PolyhedronOpts $ mempty { polyhedronOptsConvexity = First $ Just v }

fallbackPolyhedronOpts :: PolyhedronOptsInternal Identity
fallbackPolyhedronOpts = PolyhedronOptsInternal {
  polyhedronOptsPoints = pure defaultPolyhedronPoints,
  polyhedronOptsFaces = pure defaultPolyhedronFaces,
  polyhedronOptsConvexity = pure defaultConvexity
}


polyhedron :: MonadNeon m => PolyhedronOpts -> m Model3D
polyhedron (PolyhedronOpts optsMay) = do
  let
    opts :: PolyhedronOptsInternal Identity
    opts = bzipWith orDef fallbackPolyhedronOpts optsMay

  pure $ Primitive3D $ Polyhedron3D
    { polyhedronPoints = get opts.polyhedronOptsPoints
    , polyhedronFaces = Just (map (\(a, b, c) -> [a, b, c]) (get opts.polyhedronOptsFaces))
    , polyhedronConvexity = Just (get opts.polyhedronOptsConvexity)
    }

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

instance HasHeight (ExtrudeLinearOpts First) where
  height v = mempty { extrudeLinearOptsHeight = First $ Just v }

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
  fc <- askFacets
  pure $ Extrude3D (LinearExtrude
    { linearHeight    = get opts.extrudeLinearOptsHeight
    , linearCenter    = spareFlag (get opts.extrudeLinearOptsCenter)
    , linearTwist     = spareOpt (get opts.extrudeLinearOptsTwistAngle) 0
    , linearScale     = spareOpt (get opts.extrudeLinearOptsScaleFactor) 1
    , linearSlices    = case get opts.extrudeLinearOptsTwistSlices of
        Set s -> Just s
        Auto -> Nothing
    , linearConvexity = Just defaultConvexity
    , linearFacets    = Just fc
  }) [model]
  where
    opts :: ExtrudeLinearOpts Identity
    opts = bzipWith orDef fallbackExtrudeLinearOpts optsMay

-------------------------------------------------------------------------------

data ExtrudeRotationalOpts f = ExtrudeRotationalOpts {
  extrudeRotationalOptsAngle     :: f Double,
  extrudeRotationalOptsConvexity :: f Int,
  extrudeRotationalOptsFacets    :: f Facets
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
  extrudeRotationalOptsAngle     = pure 360,
  extrudeRotationalOptsConvexity = pure defaultConvexity,
  extrudeRotationalOptsFacets    = pure fc
}

extrudeRotational :: (MonadNeon m) => ExtrudeRotationalOpts First -> m Model2D -> m Model3D
extrudeRotational optsMay modelM = do
  model <- modelM
  fc <- askFacets
  
  let opts :: ExtrudeRotationalOpts Identity
      opts = bzipWith orDef (fallbackExtrudeRotationalOpts fc) optsMay

  pure $ Extrude3D (RotateExtrude
    { rotateAngle = get opts.extrudeRotationalOptsAngle
    , rotateConvexity = Just (get opts.extrudeRotationalOptsConvexity)
    , rotateFacets = Just (get opts.extrudeRotationalOptsFacets)
    })
    [model]

----

-- TODO: Implement
-- project :: (MonadNeon m) => m Model3D -> m Model2D
-- project = undefined

-------------------------------------------------------------------------------
-- / Helpers
-------------------------------------------------------------------------------

spareOpt :: Eq a => a -> a -> Maybe a
spareOpt x y = if x == y then Nothing else Just x

spareFlag :: Bool -> Maybe Bool
spareFlag b = spareOpt b False

orDef :: Identity a -> First a -> Identity a
orDef def opt = pure $ fromMaybe (runIdentity def) (getFirst opt)

get :: Identity a -> a
get = runIdentity

-------------------------------------------------------------------------------
-- / Rendering
-------------------------------------------------------------------------------

render2D :: NeonM Model2D -> String
render2D = OpenSCAD.render2D . run

render3D :: NeonM Model3D -> String
render3D = OpenSCAD.render3D . run