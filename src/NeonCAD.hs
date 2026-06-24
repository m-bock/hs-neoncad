{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE NoFieldSelectors #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}
{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module NeonCAD
  ( -- * Basic

    -- ** Vectors

    -- | Throughout the library, we use 2D and 3D vectors to represent positions and sizes.
    V2 (..),
    V3 (..),

    -- ** Monad

    -- | All model creation and modification is done in a Monad which implements the `MonadNeon` class.
    MonadNeon (askFacets, localFacets),
    -- | For most cases it is enough to use the `NeonM` monad.
    NeonM,

    -- ** Rendering

    -- | Thus rendering functions are specialized for the `NeonM` monad.
    render2D,
    render3D,

    -- * 3D Primitives

    -- ** Box

    -- |
    -- ![box](doc-imgs/box.png)
    box,
    BoxOpts,

    -- ** Cube

    -- |
    -- ![cube](doc-imgs/cube.png)
    cube,
    CubeOpts,

    -- ** Sphere

    -- |
    -- ![sphere](doc-imgs/sphere.png)
    sphere,
    SphereOpts,

    -- ** Ellipsoid

    -- |
    -- ![ellipsoid](doc-imgs/ellipsoid.png)
    ellipsoid,
    EllipsoidOpts,

    -- ** Frustum

    -- |
    -- ![frustum](doc-imgs/frustum.png)
    frustum,
    FrustumOpts,

    -- ** Cylinder

    -- |
    -- ![cylinder](doc-imgs/cylinder.png)
    cylinder,
    CylinderOpts,

    -- ** Polyhedron

    -- |
    -- ![polyhedron](doc-imgs/polyhedron.png)
    polyhedron,
    PolyhedronOpts,

    -- * 2D Primitives

    -- ** Rect

    -- |
    -- ![rect](doc-imgs/rect.png)
    rect,
    RectOpts,

    -- ** Square

    -- |
    -- ![square](doc-imgs/square.png)
    square,
    SquareOpts,

    -- ** Polygon

    -- |
    -- ![polygon](doc-imgs/polygon.png)
    polygon,
    PolygonOpts,

    -- ** Ellipse

    -- |
    -- ![ellipse](doc-imgs/ellipse.png)
    ellipse,
    EllipseOpts,

    -- ** Circle

    -- |
    -- ![circle](doc-imgs/circle.png)
    circle,
    CircleOpts,

    -- * Text

    -- |
    -- ![text](doc-imgs/text.png)
    text,
    HasFontName (fontName),
    HasFontStyle (fontStyle),
    HasDirection (direction),
    HasHorizontalAlignment (hAlign),
    HasVerticalAlignment (vAlign),
    HasSpacing (spacing),
    TextOpts,
    FontName,
    FontStyle,
    Direction,
    HorizontalAlignment,
    VerticalAlignment,

    -- * Debug

    -- ** Comment
    CanComment (comment),

    -- ** Modifiers
    CanMod (mod),
    Modifier,
    disable,
    showOnly,
    highlight,
    transparent,

    -- * Attributes

    -- ** Size
    HasSize (size),

    -- ** Placement
    HasPlacementX (placeX),
    HasPlacementY (placeY),
    HasPlacementZ (placeZ),
    placeXY,
    placeXZ,
    placeYZ,
    placeXYZ,
    Placement,

    -- ** Facets
    HasFacets (facets),
    Facets,
    HasCount (count),
    HasMaxSize (maxSize),
    HasMaxAngle (maxAngle),

    -- ** Diameter
    HasDiameter (diameter),
    radius,
    HasDiameterTop (diameterTop),
    HasDiameterBottom (diameterBottom),

    -- ** Faces
    HasFaces (faces),

    -- ** Convexity
    HasConvexity (convexity),

    -- ** Points
    HasPoints (points),

    -- ** Height
    HasHeight (height),

    -- ** Angle
    HasAngle (angle),

    -- * Facts

    -- ** Center
    IsCenter (center),

    -- ** Origin
    IsOrigin (origin),

    -- ** Left
    IsLeft (left),

    -- ** Right
    IsRight (right),

    -- * Transformations

    -- ** Move
    CanMoveXYZ (moveXYZ),
    moveBackXYZ,
    withMoveXYZ,
    CanMoveXY (moveXY),
    CanMoveXZ (moveXZ),
    CanMoveYZ (moveYZ),
    CanMoveX (moveX),
    CanMoveY (moveY),
    CanMoveZ (moveZ),

    -- ** Scale
    CanScaleXYZ (scaleXYZ),
    CanScaleXY (scaleXY),
    CanScaleXZ (scaleXZ),
    CanScaleYZ (scaleYZ),
    CanScaleX (scaleX),
    CanScaleY (scaleY),
    CanScaleZ (scaleZ),
    CanScale (scale),

    -- ** Resize
    CanResizeXYZ (resizeXYZ),
    CanResizeXY (resizeXY),
    CanResizeXZ (resizeXZ),
    CanResizeYZ (resizeYZ),
    CanResizeX (resizeX),
    CanResizeY (resizeY),
    CanResizeZ (resizeZ),
    CanResizeAutoXY (resizeAutoXY),
    CanResizeAutoXZ (resizeAutoXZ),
    CanResizeAutoYZ (resizeAutoYZ),
    CanResizeAutoX (resizeAutoX),
    CanResizeAutoY (resizeAutoY),
    CanResizeAutoZ (resizeAutoZ),

    -- ** Spin
    CanSpinXYZ (spinXYZ),
    CanSpinXY (spinXY),
    CanSpinXZ (spinXZ),
    CanSpinYZ (spinYZ),
    CanSpinX (spinX),
    CanSpinY (spinY),
    CanSpinZ (spinZ),

    -- ** Mirror
    CanMirrorXYZ (mirrorXYZ),
    CanMirrorXY (mirrorXY),
    CanMirrorXZ (mirrorXZ),
    CanMirrorYZ (mirrorYZ),
    CanMirrorX (mirrorX),
    CanMirrorY (mirrorY),
    CanMirrorZ (mirrorZ),

    -- ** Color
    CanColoring (color),
    rgb,
    alpha,

    -- ** Hull
    CanHull (hull),

    -- ** Offset
    offset,

    -- * Boolean Operations

    -- ** Union
    CanUnion (union, unions),
    empty,

    -- ** Intersection
    CanIntersection (intersection, intersections),

    -- ** Difference
    CanDifference (difference, differences),

    -- * Conversion 2D/3D

    -- ** Extrude
    extrudeLinear,
    ExtrudeLinearOpts,
    scaleFactor,
    twistAngle,
    twistSlices,
    twistSlicesAuto,
    extrudeRotational,
    ExtrudeRotationalOpts,

    -- * Models
    Model2D,
    Model3D,

    -- * Utilities
    VecTup (vec, tup),

    -- * Advanced

    -- ** Custom Monads
    NeonT,
    runNeonT,
    renderModel2D,
    renderModel3D,
  )
where

-------------------------------------------------------------------------------
-- / Imports
-------------------------------------------------------------------------------

import Barbies
import Data.Functor.Identity (Identity (runIdentity))
import Data.Maybe (fromMaybe)
import Data.Monoid (First (..))
import GHC.Generics
import Linear (V2 (..), V3 (..))
import OpenSCAD
  ( BoolOp2D (..),
    BoolOp3D (..),
    Direction (..),
    Extrude3D (..),
    Facets (..),
    Font (..),
    HorizontalAlignment (..),
    Model2D (..),
    Model3D (..),
    Modifier (..),
    Primitive2D (..),
    Primitive3D (..),
    Transform2D (..),
    Transform3D (..),
    VerticalAlignment (..),
  )
import qualified OpenSCAD as O (render2D, render3D)
import Prelude hiding (undefined)

-------------------------------------------------------------------------------
-- / Defaults
-------------------------------------------------------------------------------

defaultFacets :: Facets
defaultFacets =
  Facets
    { fn = Nothing,
      fa = Just 6,
      fs = Just 0.5
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
  vec
    ( 2 * sqrt (defaultArea * defaultRatio / pi),
      2 * sqrt (defaultArea / (defaultRatio * pi))
    )

defaultRectSize :: V2 Double
defaultRectSize =
  vec
    ( sqrt (defaultArea * defaultRatio),
      sqrt (defaultArea / defaultRatio)
    )

defaultSquareSize :: Double
defaultSquareSize = sqrt defaultArea

defaultPolygonPoints :: [V2 Double]
defaultPolygonPoints =
  map
    (\(x, y) -> vec (x * l, y * l))
    [ (0, 1),
      (1, 1),
      (1, 0),
      (0, -1),
      (-1, -1),
      (-1, 0)
    ]
  where
    l = sqrt (defaultArea / 3)

-- * 3D

defaultVolume :: Double
defaultVolume = defaultArea * defaultLength

defaultBoxSize :: V3 Double
defaultBoxSize =
  vec
    ( defaultVolume ** (1 / 3) * defaultRatio ** (2 / 3),
      defaultVolume ** (1 / 3) / defaultRatio ** (1 / 3),
      defaultVolume ** (1 / 3) / defaultRatio ** (1 / 3)
    )

defaultCubeSize :: Double
defaultCubeSize = defaultVolume ** (1 / 3)

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
   in vec (2 * a, 2 * b, 2 * b)

defaultCylinderRadius :: Double
defaultCylinderRadius = (defaultVolume / defaultRatio / pi) ** (1 / 3)

defaultCylinderDiameter :: Double
defaultCylinderDiameter = 2 * defaultCylinderRadius

defaultCylinderHeight :: Double
defaultCylinderHeight = defaultCylinderRadius * defaultRatio

defaultPolyhedronPoints :: [V3 Double]
defaultPolyhedronPoints =
  map
    (\(x, y, z) -> vec (x * 70, y * 70, z * 50))
    [ (0, -1, -1),
      (-1, 0, -1),
      (1, 0, -1),
      (1, 0, 1),
      (0, 1, 1),
      (-1, 0, 1)
    ]

defaultPolyhedronFaces :: [V3 Int]
defaultPolyhedronFaces =
  map vec [(0, 1, 2), (3, 5, 4), (0, 1, 5), (0, 2, 3), (3, 5, 0), (2, 1, 4), (1, 5, 4), (2, 3, 4)]

-------------------------------------------------------------------------------
-- / Monad
-------------------------------------------------------------------------------

class (Monad m) => MonadNeon m where
  askFacets :: m Facets
  localFacets :: Facets -> m a -> m a

newtype NeonT m a = NeonT (Facets -> m a)
  deriving (Functor)

type NeonM = NeonT Identity

runNeonT :: Facets -> NeonT m a -> m a
runNeonT factes (NeonT f) = f factes

runNeonM :: Facets -> NeonM a -> a
runNeonM fcs neon = get $ runNeonT fcs neon

renderModel2D :: Model2D -> String
renderModel2D model = O.render2D model

renderModel3D :: Model3D -> String
renderModel3D model = O.render3D model

instance (Monad m) => Applicative (NeonT m) where
  pure x = NeonT $ \_ -> pure x
  f <*> v = NeonT $ \r -> runNeonT r f <*> runNeonT r v

instance (Monad m) => Monad (NeonT m) where
  return = pure
  a >>= f = NeonT $ \r -> runNeonT r a >>= \b -> runNeonT r (f b)

instance (Monad m) => MonadNeon (NeonT m) where
  askFacets = NeonT pure
  localFacets fcs m = NeonT $ \_ -> runNeonT fcs m

-------------------------------------------------------------------------------
-- / Facets
-------------------------------------------------------------------------------

instance HasCount Facets where
  count i = mempty {fn = Just i}

instance HasMaxSize Double Facets where
  maxSize d = mempty {fs = Just d}

instance HasMaxAngle Facets where
  maxAngle d = mempty {fa = Just d}

-------------------------------------------------------------------------------
-- / Facts / IsLeft
-------------------------------------------------------------------------------

instance IsLeft HorizontalAlignment where
  left = HALeft

instance IsRight HorizontalAlignment where
  right = HARight

instance IsCenter HorizontalAlignment where
  center = HACenter

-------------------------------------------------------------------------------
-- / Attributes / HasPlacement
-------------------------------------------------------------------------------

data Placement = PlacementCenter | PlacementOrigin
  deriving (Eq)

placeXY :: (HasPlacementX a, HasPlacementY a, Semigroup a) => Placement -> a
placeXY p = placeX p <> placeY p

placeXZ :: (HasPlacementX a, HasPlacementZ a, Semigroup a) => Placement -> a
placeXZ p = placeX p <> placeZ p

placeYZ :: (HasPlacementY a, HasPlacementZ a, Semigroup a) => Placement -> a
placeYZ p = placeY p <> placeZ p

placeXYZ :: (HasPlacementX a, HasPlacementY a, HasPlacementZ a, Semigroup a) => Placement -> a
placeXYZ p = placeX p <> placeY p <> placeZ p

-------------------------------------------------------------------------------
-- / Facts / IsOrigin
-------------------------------------------------------------------------------

instance IsOrigin Placement where
  origin = PlacementOrigin

-------------------------------------------------------------------------------
-- / Facts / IsCenter
-------------------------------------------------------------------------------

instance IsCenter Placement where
  center = PlacementCenter

-------------------------------------------------------------------------------
-- / Attributes / HasDiameter
-------------------------------------------------------------------------------

radius :: (HasDiameter a) => Double -> a
radius r = diameter (r * 2)

-------------------------------------------------------------------------------

instance (MonadNeon m) => CanComment (m Model2D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment2D txt model

instance (MonadNeon m) => CanComment (m Model3D) where
  comment txt modelM = do
    model <- modelM
    pure $ Comment3D txt model

-------------------------------------------------------------------------------
-- / Modifiers / CanScale
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanScaleXY (m Model2D) where
  scaleXY xy modelM = do
    model <- modelM
    pure $ Transform2D (Scale2D $ tup xy) [model]

instance (MonadNeon m) => CanScaleX (m Model2D) where
  scaleX x modelM = scaleXY (V2 x 1) modelM

instance (MonadNeon m) => CanScaleY (m Model2D) where
  scaleY y modelM = scaleXY (V2 1 y) modelM

instance (MonadNeon m) => CanScale (m Model2D) where
  scale x modelM = scaleXY (V2 x x) modelM

-- * 3D

instance (MonadNeon m) => CanScaleXYZ (m Model3D) where
  scaleXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Scale3D (tup v)) [model]

instance (MonadNeon m) => CanScaleXY (m Model3D) where
  scaleXY (V2 x y) modelM = scaleXYZ (V3 x y 1) modelM

instance (MonadNeon m) => CanScaleXZ (m Model3D) where
  scaleXZ (V2 x z) modelM = scaleXYZ (V3 x 1 z) modelM

instance (MonadNeon m) => CanScaleYZ (m Model3D) where
  scaleYZ (V2 y z) modelM = scaleXYZ (V3 1 y z) modelM

instance (MonadNeon m) => CanScaleX (m Model3D) where
  scaleX x modelM = scaleXYZ (V3 x 1 1) modelM

instance (MonadNeon m) => CanScaleY (m Model3D) where
  scaleY y modelM = scaleXYZ (V3 1 y 1) modelM

instance (MonadNeon m) => CanScale (m Model3D) where
  scale x modelM = scaleXYZ (V3 x x x) modelM

-------------------------------------------------------------------------------
-- / Transformations / CanMove
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanMoveXY (m Model2D) where
  moveXY (V2 x y) modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (x, y, 0)) [model]

instance (MonadNeon m) => CanMoveX (m Model2D) where
  moveX x modelM = moveXY (V2 x 0) modelM

instance (MonadNeon m) => CanMoveY (m Model2D) where
  moveY y modelM = moveXY (V2 0 y) modelM

instance (MonadNeon m) => CanMoveZ (m Model2D) where
  moveZ z modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D (0, 0, z)) [model]

-- * 3D

instance (MonadNeon m) => CanMoveXYZ (m Model3D) where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Translate3D (tup v)) [model]

instance (MonadNeon m) => CanMoveXY (m Model3D) where
  moveXY (V2 x y) modelM = moveXYZ (V3 x y 0.0) modelM

instance (MonadNeon m) => CanMoveXZ (m Model3D) where
  moveXZ (V2 x z) modelM = moveXYZ (V3 x 0.0 z) modelM

instance (MonadNeon m) => CanMoveYZ (m Model3D) where
  moveYZ (V2 y z) modelM = moveXYZ (V3 0.0 y z) modelM

instance (MonadNeon m) => CanMoveX (m Model3D) where
  moveX x modelM = moveXYZ (V3 x 0.0 0.0) modelM

instance (MonadNeon m) => CanMoveY (m Model3D) where
  moveY y modelM = moveXYZ (V3 0.0 y 0.0) modelM

instance (MonadNeon m) => CanMoveZ (m Model3D) where
  moveZ z modelM = moveXYZ (V3 0.0 0.0 z) modelM

-------------------------------------------------------------------------------
-- / Transformations / CanResize
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanResizeXY (m Model2D) where
  resizeXY (V2 x y) modelM = do
    model <- modelM
    pure $ Transform2D (Resize2D (x, y) Nothing) [model]

instance (MonadNeon m) => CanResizeX (m Model2D) where
  resizeX x modelM = resizeXY (V2 x 1) modelM

instance (MonadNeon m) => CanResizeY (m Model2D) where
  resizeY y modelM = resizeXY (V2 1 y) modelM

-- * 3D

instance (MonadNeon m) => CanResizeXYZ (m Model3D) where
  resizeXYZ (V3 x y z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, z) Nothing) [model]

instance (MonadNeon m) => CanResizeXY (m Model3D) where
  resizeXY (V2 x y) modelM = resizeXYZ (V3 x y 0) modelM

instance (MonadNeon m) => CanResizeXZ (m Model3D) where
  resizeXZ (V2 x z) modelM = resizeXYZ (V3 x 1 z) modelM

instance (MonadNeon m) => CanResizeYZ (m Model3D) where
  resizeYZ (V2 y z) modelM = resizeXYZ (V3 1 y z) modelM

instance (MonadNeon m) => CanResizeX (m Model3D) where
  resizeX x modelM = resizeXYZ (V3 x 1 1) modelM

instance (MonadNeon m) => CanResizeY (m Model3D) where
  resizeY y modelM = resizeXYZ (V3 1 y 1) modelM

instance (MonadNeon m) => CanResizeZ (m Model3D) where
  resizeZ z modelM = resizeXYZ (V3 1 1 z) modelM

-------------------------------------------------------------------------------
-- / Transformations / CanResize Auto
-------------------------------------------------------------------------------

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
  resizeAutoXY (V2 x y) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, y, 0) (Just (False, False, True))) [model]

instance (MonadNeon m) => CanResizeAutoXZ (m Model3D) where
  resizeAutoXZ (V2 x z) modelM = do
    model <- modelM
    pure $ Transform3D (Resize3D (x, 0, z) (Just (False, True, False))) [model]

instance (MonadNeon m) => CanResizeAutoYZ (m Model3D) where
  resizeAutoYZ (V2 y z) modelM = do
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
-- / Transformations / CanSpin
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanSpinZ (m Model2D) where
  spinZ z modelM = do
    model <- modelM
    pure $ Transform2D (RotateEuler2D (0, 0, z)) [model]

-- * 3D

instance (MonadNeon m) => CanSpinXYZ (m Model3D) where
  spinXYZ (V3 x y z) modelM = do
    model <- modelM
    pure $ Transform3D (RotateEuler3D (x, y, z)) [model]

instance (MonadNeon m) => CanSpinXY (m Model3D) where
  spinXY (V2 x y) modelM = spinXYZ (V3 x y 0) modelM

instance (MonadNeon m) => CanSpinXZ (m Model3D) where
  spinXZ (V2 x z) modelM = spinXYZ (V3 x 0 z) modelM

instance (MonadNeon m) => CanSpinYZ (m Model3D) where
  spinYZ (V2 y z) modelM = spinXYZ (V3 0 y z) modelM

instance (MonadNeon m) => CanSpinX (m Model3D) where
  spinX x modelM = spinXYZ (V3 x 0 0) modelM

instance (MonadNeon m) => CanSpinY (m Model3D) where
  spinY y modelM = spinXYZ (V3 0 y 0) modelM

instance (MonadNeon m) => CanSpinZ (m Model3D) where
  spinZ z modelM = spinXYZ (V3 0 0 z) modelM

-------------------------------------------------------------------------------
-- / Transformations / CanMirror
-------------------------------------------------------------------------------

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
  mirrorXY (V2 x y) modelM = do
    model <- modelM
    pure $ Transform2D (Mirror2D (x, y)) [model]

-- * 3D

instance (MonadNeon m) => CanMirrorXYZ (m Model3D) where
  mirrorXYZ (V3 x y z) modelM = do
    model <- modelM
    pure $ Transform3D (Mirror3D (x, y, z)) [model]

instance (MonadNeon m) => CanMirrorXY (m Model3D) where
  mirrorXY (V2 x y) modelM = mirrorXYZ (V3 x y 0) modelM

instance (MonadNeon m) => CanMirrorXZ (m Model3D) where
  mirrorXZ (V2 x z) modelM = mirrorXYZ (V3 x 0 z) modelM

instance (MonadNeon m) => CanMirrorYZ (m Model3D) where
  mirrorYZ (V2 y z) modelM = mirrorXYZ (V3 0 y z) modelM

instance (MonadNeon m) => CanMirrorX (m Model3D) where
  mirrorX modelM = mirrorXYZ (V3 1 0 0) modelM

instance (MonadNeon m) => CanMirrorY (m Model3D) where
  mirrorY modelM = mirrorXYZ (V3 0 1 0) modelM

instance (MonadNeon m) => CanMirrorZ (m Model3D) where
  mirrorZ z modelM = mirrorXYZ (V3 0 0 z) modelM

-------------------------------------------------------------------------------
-- / Attributes / Color
-------------------------------------------------------------------------------

data ColorOpts f = ColorOpts
  { colorOptsRgb :: f (V3 Double),
    colorOptsAlpha :: f Double
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (ColorOpts First)
  instance
    Semigroup (ColorOpts First)

deriving via
  Generically (ColorOpts First)
  instance
    Monoid (ColorOpts First)

fallbackColorOpts :: ColorOpts Identity
fallbackColorOpts =
  ColorOpts
    { colorOptsRgb = pure $ vec (0, 0, 0),
      colorOptsAlpha = pure 1
    }

rgb :: V3 Double -> ColorOpts First
rgb rgbValues = mempty {colorOptsRgb = First $ Just rgbValues}

alpha :: Double -> ColorOpts First
alpha alphaValue = mempty {colorOptsAlpha = First $ Just alphaValue}

-- * 2D

instance (MonadNeon m) => CanColoring (m Model2D) where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform2D (Color2D (tup $ get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts :: ColorOpts Identity
      opts = bzipWith orDef fallbackColorOpts optsMay

-- * 3D

instance (MonadNeon m) => CanColoring (m Model3D) where
  color optsMay modelM = do
    model <- modelM
    pure $ Transform3D (Color3D (tup $ get opts.colorOptsRgb) (Just (get opts.colorOptsAlpha))) [model]
    where
      opts :: ColorOpts Identity
      opts = bzipWith orDef fallbackColorOpts optsMay

-------------------------------------------------------------------------------
-- / Transformations / Hull
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanHull (m Model2D) where
  hull modelM = do
    model <- modelM
    pure $ Transform2D Hull2D [model]

-- * 3D

instance (MonadNeon m) => CanHull (m Model3D) where
  hull modelM = do
    model <- modelM
    pure $ Transform3D Hull3D [model]

-------------------------------------------------------------------------------
-- / Boolean Operations / Union
-------------------------------------------------------------------------------

empty :: (CanUnion a) => a
empty = unions []

-- * 2D

instance (MonadNeon m) => CanUnion (m Model2D) where
  union modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Union2D [modelA, modelB]

  unions modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Union2D models

-- * 3D

instance (MonadNeon m) => CanUnion (m Model3D) where
  union modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Union3D [modelA, modelB]

  unions modelsM = do
    models <- sequence modelsM
    pure $ BoolOp3D Union3D models

-------------------------------------------------------------------------------
-- / Boolean Operations / Intersection
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanIntersection (m Model2D) where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Intersection2D [modelA, modelB]

  intersections modelsM = do
    models <- sequence modelsM
    pure $ BoolOp2D Intersection2D models

-- * 3D

instance (MonadNeon m) => CanIntersection (m Model3D) where
  intersection modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Intersection3D [modelA, modelB]

  intersections modelsM = do
    models <- sequence modelsM
    pure $ BoolOp3D Intersection3D models

-------------------------------------------------------------------------------
-- / Boolean Operations / Difference
-------------------------------------------------------------------------------

-- * 2D

instance (MonadNeon m) => CanDifference (m Model2D) where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp2D Difference2D [modelA, modelB]

  differences baseModelM modelsM = do
    baseModel <- baseModelM
    models <- sequence modelsM
    pure $ BoolOp2D Difference2D (baseModel : models)

-- * 3D

instance (MonadNeon m) => CanDifference (m Model3D) where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ BoolOp3D Difference3D [modelA, modelB]

  differences baseModelM modelsM = do
    baseModel <- baseModelM
    models <- sequence modelsM
    pure $ BoolOp3D Difference3D (baseModel : models)

-------------------------------------------------------------------------------
-- / Transformations / Modifiers
-------------------------------------------------------------------------------

disable :: Modifier
disable = ModDisable

showOnly :: Modifier
showOnly = ModShowOnly

highlight :: Modifier
highlight = ModHighlight

transparent :: Modifier
transparent = ModTransparent

-- * 2D

instance (MonadNeon m) => CanMod (m Model2D) where
  mod m modelM = do
    model <- modelM
    pure $ Modifier2D m model

-- * 3D

instance (MonadNeon m) => CanMod (m Model3D) where
  mod m modelM = do
    model <- modelM
    pure $ Modifier3D m model

-------------------------------------------------------------------------------
-- / Primitives / 2D / Circle
-------------------------------------------------------------------------------

newtype CircleOpts = CircleOpts (CircleOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data CircleOptsInternal f = CircleOptsInternal
  { circleOptsDiameter :: f Double,
    circleOptsPlacementX :: f Placement,
    circleOptsPlacementY :: f Placement,
    circleOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (CircleOptsInternal First)
  instance
    Semigroup (CircleOptsInternal First)

deriving via
  Generically (CircleOptsInternal First)
  instance
    Monoid (CircleOptsInternal First)

fallbackCircleOpts :: Facets -> CircleOptsInternal Identity
fallbackCircleOpts fc =
  CircleOptsInternal
    { circleOptsDiameter = pure defaultCircleDiameter,
      circleOptsPlacementX = pure PlacementCenter,
      circleOptsPlacementY = pure PlacementCenter,
      circleOptsFacets = pure fc
    }

instance HasDiameter CircleOpts where
  diameter v = CircleOpts $ mempty {circleOptsDiameter = First $ Just v}

instance HasFacets CircleOpts where
  facets v = CircleOpts $ mempty {circleOptsFacets = First $ Just v}

instance HasPlacementX CircleOpts where
  placeX v = CircleOpts $ mempty {circleOptsPlacementX = First $ Just v}

instance HasPlacementY CircleOpts where
  placeY v = CircleOpts $ mempty {circleOptsPlacementY = First $ Just v}

circle :: (MonadNeon m) => CircleOpts -> m Model2D
circle (CircleOpts optsMay) = do
  fc <- askFacets

  let opts :: CircleOptsInternal Identity
      opts = bzipWith orDef (fallbackCircleOpts fc) optsMay

      d = get opts.circleOptsDiameter

  handlePlacement2
    (V2 PlacementCenter PlacementCenter)
    (V2 (get opts.circleOptsPlacementX) (get opts.circleOptsPlacementY))
    (V2 d d)
    $ pure
    $ Primitive2D
    $ Circle2D
      { circleDiameter = get opts.circleOptsDiameter,
        circleFacets = Just (get opts.circleOptsFacets)
      }

-------------------------------------------------------------------------------
-- / Primitives / 2D / Ellipse
-------------------------------------------------------------------------------

newtype EllipseOpts = EllipseOpts (EllipseOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data EllipseOptsInternal f = EllipseOptsInternal
  { ellipseOptsSize :: f (V2 Double),
    ellipseOptsPlacementX :: f Placement,
    ellipseOptsPlacementY :: f Placement,
    ellipseOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

instance HasSize (V2 Double) EllipseOpts where
  size v = EllipseOpts $ mempty {ellipseOptsSize = First $ Just v}

instance HasPlacementX EllipseOpts where
  placeX v = EllipseOpts $ mempty {ellipseOptsPlacementX = First $ Just v}

instance HasPlacementY EllipseOpts where
  placeY v = EllipseOpts $ mempty {ellipseOptsPlacementY = First $ Just v}

instance HasFacets EllipseOpts where
  facets v = EllipseOpts $ mempty {ellipseOptsFacets = First $ Just v}

deriving via
  Generically (EllipseOptsInternal First)
  instance
    Semigroup (EllipseOptsInternal First)

deriving via
  Generically (EllipseOptsInternal First)
  instance
    Monoid (EllipseOptsInternal First)

fallbackEllipseOpts :: Facets -> EllipseOptsInternal Identity
fallbackEllipseOpts fc =
  EllipseOptsInternal
    { ellipseOptsSize = pure defaultEllipseSize,
      ellipseOptsPlacementX = pure PlacementCenter,
      ellipseOptsPlacementY = pure PlacementCenter,
      ellipseOptsFacets = pure fc
    }

ellipse :: (MonadNeon m) => EllipseOpts -> m Model2D
ellipse (EllipseOpts optsMay) = do
  fc <- askFacets
  let opts :: EllipseOptsInternal Identity
      opts = bzipWith orDef (fallbackEllipseOpts fc) optsMay

      V2 dx dy = get opts.ellipseOptsSize

  handlePlacement2
    (V2 PlacementCenter PlacementCenter)
    (V2 (get opts.ellipseOptsPlacementX) (get opts.ellipseOptsPlacementY))
    (V2 dx dy)
    $ resizeXY (V2 dx dy)
    $ circle (diameter (max dx dy) <> facets (get opts.ellipseOptsFacets))

-------------------------------------------------------------------------------
-- / Primitives / 2D / Rect
-------------------------------------------------------------------------------

newtype RectOpts = RectOpts (RectOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data RectOptsInternal f = RectOptsInternal
  { rectOptsSize :: f (V2 Double),
    rectOptsPlacementX :: f Placement,
    rectOptsPlacementY :: f Placement
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (RectOptsInternal First)
  instance
    Semigroup (RectOptsInternal First)

deriving via
  Generically (RectOptsInternal First)
  instance
    Monoid (RectOptsInternal First)

fallbackRectOpts :: RectOptsInternal Identity
fallbackRectOpts =
  RectOptsInternal
    { rectOptsSize = pure defaultRectSize,
      rectOptsPlacementX = pure PlacementCenter,
      rectOptsPlacementY = pure PlacementCenter
    }

instance HasPlacementX RectOpts where
  placeX v = RectOpts $ mempty {rectOptsPlacementX = First $ Just v}

instance HasPlacementY RectOpts where
  placeY v = RectOpts $ mempty {rectOptsPlacementY = First $ Just v}

instance HasSize (V2 Double) RectOpts where
  size v = RectOpts $ mempty {rectOptsSize = First $ Just v}

rect :: (MonadNeon m) => RectOpts -> m Model2D
rect (RectOpts optsMay) =
  handlePlacement2
    (V2 PlacementOrigin PlacementOrigin)
    (V2 (get opts.rectOptsPlacementX) (get opts.rectOptsPlacementY))
    (V2 dx dy)
    $ pure
    $ Primitive2D
    $ Square2D
      { squareSize = tup $ get opts.rectOptsSize,
        squareCenter = Nothing
      }
  where
    opts :: RectOptsInternal Identity
    opts = bzipWith orDef fallbackRectOpts optsMay

    V2 dx dy = get opts.rectOptsSize

-------------------------------------------------------------------------------
-- / Primitives / 2D / Square
-------------------------------------------------------------------------------

newtype SquareOpts = SquareOpts (SquareOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data SquareOptsInternal f = SquareOptsInternal
  { squareOptsSize :: f Double,
    squareOptsPlacementX :: f Placement,
    squareOptsPlacementY :: f Placement
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (SquareOptsInternal First)
  instance
    Semigroup (SquareOptsInternal First)

deriving via
  Generically (SquareOptsInternal First)
  instance
    Monoid (SquareOptsInternal First)

fallbackSquareOpts :: SquareOptsInternal Identity
fallbackSquareOpts =
  SquareOptsInternal
    { squareOptsSize = pure defaultSquareSize,
      squareOptsPlacementX = pure PlacementCenter,
      squareOptsPlacementY = pure PlacementCenter
    }

instance HasSize Double SquareOpts where
  size v = SquareOpts $ mempty {squareOptsSize = First $ Just v}

instance HasPlacementX SquareOpts where
  placeX v = SquareOpts $ mempty {squareOptsPlacementX = First $ Just v}

instance HasPlacementY SquareOpts where
  placeY v = SquareOpts $ mempty {squareOptsPlacementY = First $ Just v}

square :: (MonadNeon m) => SquareOpts -> m Model2D
square (SquareOpts optsMay) =
  handlePlacement2
    (V2 PlacementOrigin PlacementOrigin)
    (V2 (get opts.squareOptsPlacementX) (get opts.squareOptsPlacementY))
    (V2 s s)
    $ pure
    $ Primitive2D
    $ Square2D
      { squareSize = (s, s),
        squareCenter = Nothing
      }
  where
    opts :: SquareOptsInternal Identity
    opts = bzipWith orDef fallbackSquareOpts optsMay
    s = get opts.squareOptsSize

-------------------------------------------------------------------------------
-- / Primitives / 2D / Polygon
-------------------------------------------------------------------------------

-- Paths are not supported yet, because they can be modeled with difference.
-- Maybe in the future paths can be added for ergonomics if needed.

newtype PolygonOpts = PolygonOpts (PolygonOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data PolygonOptsInternal f = PolygonOptsInternal
  { polygonOptsPoints :: f [V2 Double],
    polygonOptsConvexity :: f Int
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (PolygonOptsInternal First)
  instance
    Semigroup (PolygonOptsInternal First)

deriving via
  Generically (PolygonOptsInternal First)
  instance
    Monoid (PolygonOptsInternal First)

instance HasPoints V2 PolygonOpts where
  points v = PolygonOpts $ mempty {polygonOptsPoints = First $ Just $ v}

fallbackPolygonOpts :: PolygonOptsInternal Identity
fallbackPolygonOpts =
  PolygonOptsInternal
    { polygonOptsPoints = pure defaultPolygonPoints,
      polygonOptsConvexity = pure defaultConvexity
    }

polygon :: (MonadNeon m) => PolygonOpts -> m Model2D
polygon (PolygonOpts optsMay) =
  pure $
    Primitive2D $
      Polygon2D
        { polygonPoints = map tup $ get opts.polygonOptsPoints,
          polygonConvexity = Just $ get opts.polygonOptsConvexity,
          polygonPaths = Nothing
        }
  where
    opts :: PolygonOptsInternal Identity
    opts = bzipWith orDef fallbackPolygonOpts optsMay

-------------------------------------------------------------------------------
-- / Primitives / 2D / Text
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

newtype TextOpts = TextOpts (TextOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data TextOptsInternal f = TextOptsInternal
  { textOptsFont :: f FontName,
    textOptsSize :: f Double,
    textOptsStyle :: f FontStyle,
    textOptsDirection :: f Direction,
    textOptsHAlign :: f HorizontalAlignment,
    textOptsVAlign :: f VerticalAlignment,
    textOptsSpacing :: f Double
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (TextOptsInternal First)
  instance
    Semigroup (TextOptsInternal First)

deriving via
  Generically (TextOptsInternal First)
  instance
    Monoid (TextOptsInternal First)

instance HasFontName TextOpts where
  fontName n = TextOpts $ mempty {textOptsFont = First $ Just n}

instance HasFontStyle TextOpts where
  fontStyle s = TextOpts $ mempty {textOptsStyle = First $ Just s}

instance HasDirection TextOpts where
  direction dir = TextOpts $ mempty {textOptsDirection = First $ Just dir}

instance HasHorizontalAlignment TextOpts where
  hAlign ha = TextOpts $ mempty {textOptsHAlign = First $ Just ha}

instance HasVerticalAlignment TextOpts where
  vAlign va = TextOpts $ mempty {textOptsVAlign = First $ Just va}

instance HasSpacing TextOpts where
  spacing s = TextOpts $ mempty {textOptsSpacing = First $ Just s}

fallbackTextOpts :: TextOptsInternal Identity
fallbackTextOpts =
  TextOptsInternal
    { textOptsFont = pure FNLiberationSans,
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
  FSRegular -> "Regular"
  FSBold -> "Bold"
  FSItalic -> "Italic"
  FSBoldItalic -> "Bold Italic"

mkFont :: Maybe FontName -> Maybe FontStyle -> Maybe Font
mkFont fontNameMay style = case (fontNameMay, style) of
  (Nothing, Nothing) -> Nothing
  (Just n, mayStyle) ->
    Just $
      Font
        { fontFamily = fontNameToString n,
          fontOptions = case mayStyle of
            Just s -> [("style", fontStyleToString s)]
            Nothing -> []
        }
  (Nothing, mayStyle) -> mkFont (Just FNLiberationSans) mayStyle

text :: (MonadNeon m) => String -> TextOpts -> m Model2D
text s (TextOpts optsMay) = do
  fc <- askFacets
  pure $
    Primitive2D $
      Text2D
        { textText = s,
          textSize = fmap get $ spareOpt opts.textOptsSize 10,
          textFont =
            mkFont
              (fmap get $ spareOpt opts.textOptsFont (pure FNLiberationSans))
              (fmap get $ spareOpt opts.textOptsStyle (pure FSRegular)),
          textDirection = fmap get $ spareOpt opts.textOptsDirection (pure LeftToRight),
          textHAlign = fmap get $ spareOpt opts.textOptsHAlign (pure HALeft),
          textVAlign = fmap get $ spareOpt opts.textOptsVAlign (pure VABaseline),
          textSpacing = fmap get $ spareOpt opts.textOptsSpacing (pure 1),
          textEm = Nothing,
          textFacets = Just fc,
          textLanguage = Nothing,
          textScript = Nothing
        }
  where
    opts :: TextOptsInternal Identity
    opts = bzipWith orDef fallbackTextOpts optsMay

-------------------------------------------------------------------------------
-- / Transformations / Offset
-------------------------------------------------------------------------------

offset :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offset d modelM = do
  model <- modelM
  pure $
    Transform2D
      ( OffsetDelta2D
          { offsetDeltaDelta = d,
            offsetDeltaChamfer = Nothing
          }
      )
      [model]

-- TODO: Implement
-- offsetRound :: (MonadNeon m) => Double -> m Model2D -> m Model2D
-- offsetRound = undefined

-- TODO: Implement
-- offsetCut :: (MonadNeon m) => Double -> m Model2D -> m Model2D
-- offsetCut = undefined

-------------------------------------------------------------------------------
-- / Primitives / 3D / Box
-------------------------------------------------------------------------------

newtype BoxOpts = BoxOpts (BoxOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data BoxOptsInternal f = BoxOptsInternal
  { boxOptsSize :: f (V3 Double),
    boxOptsPlacementX :: f Placement,
    boxOptsPlacementY :: f Placement,
    boxOptsPlacementZ :: f Placement
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (BoxOptsInternal First)
  instance
    Semigroup (BoxOptsInternal First)

deriving via
  Generically (BoxOptsInternal First)
  instance
    Monoid (BoxOptsInternal First)

fallbackBoxOpts :: BoxOptsInternal Identity
fallbackBoxOpts =
  BoxOptsInternal
    { boxOptsSize = pure defaultBoxSize,
      boxOptsPlacementX = pure PlacementCenter,
      boxOptsPlacementY = pure PlacementCenter,
      boxOptsPlacementZ = pure PlacementCenter
    }

instance HasSize (V3 Double) BoxOpts where
  size v = BoxOpts $ mempty {boxOptsSize = First $ Just v}

instance HasPlacementX BoxOpts where
  placeX v = BoxOpts $ mempty {boxOptsPlacementX = First $ Just v}

instance HasPlacementY BoxOpts where
  placeY v = BoxOpts $ mempty {boxOptsPlacementY = First $ Just v}

instance HasPlacementZ BoxOpts where
  placeZ v = BoxOpts $ mempty {boxOptsPlacementZ = First $ Just v}

box :: (MonadNeon m) => BoxOpts -> m Model3D
box (BoxOpts optsMay) =
  handlePlacement3
    (V3 PlacementOrigin PlacementOrigin PlacementOrigin)
    (V3 (get opts.boxOptsPlacementX) (get opts.boxOptsPlacementY) (get opts.boxOptsPlacementZ))
    (V3 dx dy dz)
    $ pure
    $ Primitive3D
    $ Cube3D
      { cubeSize = tup $ get opts.boxOptsSize,
        cubeCenter = Nothing
      }
  where
    opts :: BoxOptsInternal Identity
    opts = bzipWith orDef fallbackBoxOpts optsMay

    V3 dx dy dz = get opts.boxOptsSize

-------------------------------------------------------------------------------
-- / Primitives / 3D / Cube
-------------------------------------------------------------------------------

newtype CubeOpts = CubeOpts (CubeOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data CubeOptsInternal f = CubeOptsInternal
  { cubeOptsSize :: f Double,
    cubeOptsPlacementX :: f Placement,
    cubeOptsPlacementY :: f Placement,
    cubeOptsPlacementZ :: f Placement
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (CubeOptsInternal First)
  instance
    Semigroup (CubeOptsInternal First)

deriving via
  Generically (CubeOptsInternal First)
  instance
    Monoid (CubeOptsInternal First)

fallbackCubeOpts :: CubeOptsInternal Identity
fallbackCubeOpts =
  CubeOptsInternal
    { cubeOptsSize = pure defaultCubeSize,
      cubeOptsPlacementX = pure PlacementCenter,
      cubeOptsPlacementY = pure PlacementCenter,
      cubeOptsPlacementZ = pure PlacementCenter
    }

instance HasSize Double CubeOpts where
  size v = CubeOpts $ mempty {cubeOptsSize = First $ Just v}

instance HasPlacementX CubeOpts where
  placeX v = CubeOpts $ mempty {cubeOptsPlacementX = First $ Just v}

instance HasPlacementY CubeOpts where
  placeY v = CubeOpts $ mempty {cubeOptsPlacementY = First $ Just v}

instance HasPlacementZ CubeOpts where
  placeZ v = CubeOpts $ mempty {cubeOptsPlacementZ = First $ Just v}

cube :: (MonadNeon m) => CubeOpts -> m Model3D
cube (CubeOpts optsMay) =
  handlePlacement3
    (V3 PlacementOrigin PlacementOrigin PlacementOrigin)
    (V3 (get opts.cubeOptsPlacementX) (get opts.cubeOptsPlacementY) (get opts.cubeOptsPlacementZ))
    (V3 s s s)
    $ pure
    $ Primitive3D
    $ Cube3D
      { cubeSize = tup (V3 s s s),
        cubeCenter = Nothing
      }
  where
    s = get opts.cubeOptsSize

    opts :: CubeOptsInternal Identity
    opts = bzipWith orDef fallbackCubeOpts optsMay

-------------------------------------------------------------------------------
-- / Primitives / 3D / Sphere
-------------------------------------------------------------------------------

newtype SphereOpts = SphereOpts (SphereOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data SphereOptsInternal f = SphereOptsInternal
  { sphereOptsDiameter :: f Double,
    sphereOptsPlacementX :: f Placement,
    sphereOptsPlacementY :: f Placement,
    sphereOptsPlacementZ :: f Placement,
    sphereOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (SphereOptsInternal First)
  instance
    Semigroup (SphereOptsInternal First)

deriving via
  Generically (SphereOptsInternal First)
  instance
    Monoid (SphereOptsInternal First)

fallbackSphereOpts :: Facets -> SphereOptsInternal Identity
fallbackSphereOpts fc =
  SphereOptsInternal
    { sphereOptsDiameter = pure defaultSphereDiameter,
      sphereOptsPlacementX = pure PlacementCenter,
      sphereOptsPlacementY = pure PlacementCenter,
      sphereOptsPlacementZ = pure PlacementCenter,
      sphereOptsFacets = pure fc
    }

instance HasDiameter SphereOpts where
  diameter v = SphereOpts $ mempty {sphereOptsDiameter = First $ Just v}

instance HasPlacementX SphereOpts where
  placeX v = SphereOpts $ mempty {sphereOptsPlacementX = First $ Just v}

instance HasPlacementY SphereOpts where
  placeY v = SphereOpts $ mempty {sphereOptsPlacementY = First $ Just v}

instance HasPlacementZ SphereOpts where
  placeZ v = SphereOpts $ mempty {sphereOptsPlacementZ = First $ Just v}

instance HasFacets SphereOpts where
  facets v = SphereOpts $ mempty {sphereOptsFacets = First $ Just v}

sphere :: (MonadNeon m) => SphereOpts -> m Model3D
sphere (SphereOpts optsMay) = do
  fc <- askFacets
  let opts :: SphereOptsInternal Identity
      opts = bzipWith orDef (fallbackSphereOpts fc) optsMay

      d = get opts.sphereOptsDiameter

  handlePlacement3
    (V3 PlacementCenter PlacementCenter PlacementCenter)
    (V3 (get opts.sphereOptsPlacementX) (get opts.sphereOptsPlacementY) (get opts.sphereOptsPlacementZ))
    (V3 d d d)
    $ pure
    $ Primitive3D
    $ Sphere3D
      { sphereDiameter = d,
        sphereFacets = Just (get opts.sphereOptsFacets)
      }

-------------------------------------------------------------------------------
-- / Primitives / 3D / Ellipsoid
-------------------------------------------------------------------------------

newtype EllipsoidOpts = EllipsoidOpts (EllipsoidOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data EllipsoidOptsInternal f = EllipsoidOptsInternal
  { ellipsoidOptsSize :: f (V3 Double),
    ellipsoidOptsPlacementX :: f Placement,
    ellipsoidOptsPlacementY :: f Placement,
    ellipsoidOptsPlacementZ :: f Placement,
    ellipsoidOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (EllipsoidOptsInternal First)
  instance
    Semigroup (EllipsoidOptsInternal First)

deriving via
  Generically (EllipsoidOptsInternal First)
  instance
    Monoid (EllipsoidOptsInternal First)

fallbackEllipsoidOpts :: Facets -> EllipsoidOptsInternal Identity
fallbackEllipsoidOpts fc =
  EllipsoidOptsInternal
    { ellipsoidOptsSize = pure defaultEllipsoidSize,
      ellipsoidOptsPlacementX = pure PlacementCenter,
      ellipsoidOptsPlacementY = pure PlacementCenter,
      ellipsoidOptsPlacementZ = pure PlacementCenter,
      ellipsoidOptsFacets = pure fc
    }

instance HasSize (V3 Double) EllipsoidOpts where
  size v = EllipsoidOpts $ mempty {ellipsoidOptsSize = First $ Just v}

instance HasPlacementX EllipsoidOpts where
  placeX v = EllipsoidOpts $ mempty {ellipsoidOptsPlacementX = First $ Just v}

instance HasPlacementY EllipsoidOpts where
  placeY v = EllipsoidOpts $ mempty {ellipsoidOptsPlacementY = First $ Just v}

instance HasPlacementZ EllipsoidOpts where
  placeZ v = EllipsoidOpts $ mempty {ellipsoidOptsPlacementZ = First $ Just v}

instance HasFacets EllipsoidOpts where
  facets v = EllipsoidOpts $ mempty {ellipsoidOptsFacets = First $ Just v}

ellipsoid :: (MonadNeon m) => EllipsoidOpts -> m Model3D
ellipsoid (EllipsoidOpts optsMay) = do
  fc <- askFacets
  let opts :: EllipsoidOptsInternal Identity
      opts = bzipWith orDef (fallbackEllipsoidOpts fc) optsMay

      V3 dx dy dz = get opts.ellipsoidOptsSize
      dmax = max (max dx dy) dz

  handlePlacement3
    (V3 PlacementCenter PlacementCenter PlacementCenter)
    (V3 (get opts.ellipsoidOptsPlacementX) (get opts.ellipsoidOptsPlacementY) (get opts.ellipsoidOptsPlacementZ))
    (V3 dx dy dz)
    $ resizeXYZ (V3 dx dy dz)
    $ pure
    $ Primitive3D
    $ Sphere3D
      { sphereDiameter = dmax,
        sphereFacets = Just (get opts.ellipsoidOptsFacets)
      }

-------------------------------------------------------------------------------
-- / Primitives / 3D / Frustum
-------------------------------------------------------------------------------

newtype FrustumOpts = FrustumOpts (FrustumOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data FrustumOptsInternal f = FrustumOptsInternal
  { frustumOptsHeight :: f Double,
    frustumOptsDiameterTop :: f Double,
    frustumOptsDiameterBottom :: f Double,
    frustumOptsPlacementZ :: f Placement,
    frustumOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (FrustumOptsInternal First)
  instance
    Semigroup (FrustumOptsInternal First)

deriving via
  Generically (FrustumOptsInternal First)
  instance
    Monoid (FrustumOptsInternal First)

instance HasHeight FrustumOpts where
  height v = FrustumOpts $ mempty {frustumOptsHeight = First $ Just v}

instance HasDiameterTop FrustumOpts where
  diameterTop d = FrustumOpts $ mempty {frustumOptsDiameterTop = First $ Just d}

instance HasDiameterBottom FrustumOpts where
  diameterBottom d = FrustumOpts $ mempty {frustumOptsDiameterBottom = First $ Just d}

instance HasPlacementZ FrustumOpts where
  placeZ v = FrustumOpts $ mempty {frustumOptsPlacementZ = First $ Just v}

instance HasFacets FrustumOpts where
  facets v = FrustumOpts $ mempty {frustumOptsFacets = First $ Just v}

defaultFrustumRadiusTop :: Double
defaultFrustumRadiusTop = (3 * defaultVolume / (2 * pi * (defaultRatio ^ (2 :: Integer)) * (1 + defaultRatio + defaultRatio ^ (2 :: Integer)))) ** (1 / 3)

defaultFrustumDiameterTop :: Double
defaultFrustumDiameterTop = defaultFrustumRadiusTop * 2

defaultFrustumRadiusBottom :: Double
defaultFrustumRadiusBottom = defaultFrustumRadiusTop * defaultRatio

defaultFrustumDiameterBottom :: Double
defaultFrustumDiameterBottom = defaultFrustumRadiusBottom * 2

defaultFrustumHeight :: Double
defaultFrustumHeight = defaultFrustumDiameterBottom * defaultRatio

fallbackFrustumOpts :: Facets -> FrustumOptsInternal Identity
fallbackFrustumOpts fc =
  FrustumOptsInternal
    { frustumOptsHeight = pure defaultFrustumHeight,
      frustumOptsDiameterTop = pure defaultFrustumDiameterTop,
      frustumOptsDiameterBottom = pure defaultFrustumDiameterBottom,
      frustumOptsPlacementZ = pure PlacementCenter,
      frustumOptsFacets = pure fc
    }

frustum :: (MonadNeon m) => FrustumOpts -> m Model3D
frustum (FrustumOpts optsMay) = do
  fc <- askFacets
  let opts :: FrustumOptsInternal Identity
      opts = bzipWith orDef (fallbackFrustumOpts fc) optsMay

      h = get opts.frustumOptsHeight

      handlePlacementZ = case get opts.frustumOptsPlacementZ of
        PlacementCenter -> moveZ (-h / 2)
        PlacementOrigin -> id

  handlePlacementZ $
    pure $
      Primitive3D $
        Cylinder3D
          { cylinderHeight = get opts.frustumOptsHeight,
            cylinderCenter = Nothing,
            cylinderDiameter1 = get opts.frustumOptsDiameterBottom,
            cylinderDiameter2 = get opts.frustumOptsDiameterTop,
            cylinderFacets = Just (get opts.frustumOptsFacets)
          }

-------------------------------------------------------------------------------
-- / Primitives / 3D / Cylinder
-------------------------------------------------------------------------------

newtype CylinderOpts = CylinderOpts (CylinderOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data CylinderOptsInternal f = CylinderOptsInternal
  { cylinderOptsHeight :: f Double,
    cylinderOptsDiameter :: f Double,
    cylinderOptsPlacementX :: f Placement,
    cylinderOptsPlacementY :: f Placement,
    cylinderOptsPlacementZ :: f Placement,
    cylinderOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (CylinderOptsInternal First)
  instance
    Semigroup (CylinderOptsInternal First)

deriving via
  Generically (CylinderOptsInternal First)
  instance
    Monoid (CylinderOptsInternal First)

instance HasHeight CylinderOpts where
  height v = CylinderOpts $ mempty {cylinderOptsHeight = First $ Just v}

instance HasDiameter CylinderOpts where
  diameter v = CylinderOpts $ mempty {cylinderOptsDiameter = First $ Just v}

instance HasPlacementX CylinderOpts where
  placeX v = CylinderOpts $ mempty {cylinderOptsPlacementX = First $ Just v}

instance HasPlacementY CylinderOpts where
  placeY v = CylinderOpts $ mempty {cylinderOptsPlacementY = First $ Just v}

instance HasPlacementZ CylinderOpts where
  placeZ v = CylinderOpts $ mempty {cylinderOptsPlacementZ = First $ Just v}

instance HasFacets CylinderOpts where
  facets v = CylinderOpts $ mempty {cylinderOptsFacets = First $ Just v}

fallbackCylinderOpts :: Facets -> CylinderOptsInternal Identity
fallbackCylinderOpts fc =
  CylinderOptsInternal
    { cylinderOptsHeight = pure defaultCylinderHeight,
      cylinderOptsDiameter = pure defaultCylinderDiameter,
      cylinderOptsPlacementX = pure PlacementCenter,
      cylinderOptsPlacementY = pure PlacementCenter,
      cylinderOptsPlacementZ = pure PlacementCenter,
      cylinderOptsFacets = pure fc
    }

cylinder :: (MonadNeon m) => CylinderOpts -> m Model3D
cylinder (CylinderOpts optsMay) = do
  fc <- askFacets
  let opts :: CylinderOptsInternal Identity
      opts = bzipWith orDef (fallbackCylinderOpts fc) optsMay

      h = get opts.cylinderOptsHeight

      dia = get opts.cylinderOptsDiameter

  handlePlacement3
    (V3 PlacementCenter PlacementCenter PlacementOrigin)
    (V3 (get opts.cylinderOptsPlacementX) (get opts.cylinderOptsPlacementY) (get opts.cylinderOptsPlacementZ))
    (V3 dia dia h)
    $ pure
    $ Primitive3D
    $ Cylinder3D
      { cylinderHeight = get opts.cylinderOptsHeight,
        cylinderCenter = Nothing,
        cylinderDiameter1 = dia,
        cylinderDiameter2 = dia,
        cylinderFacets = Just (get opts.cylinderOptsFacets)
      }

-------------------------------------------------------------------------------
-- / Primitives / 3D / Polyhedron
-------------------------------------------------------------------------------

newtype PolyhedronOpts = PolyhedronOpts (PolyhedronOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data PolyhedronOptsInternal f = PolyhedronOptsInternal
  { polyhedronOptsPoints :: f [V3 Double],
    polyhedronOptsFaces :: f [V3 Int],
    polyhedronOptsConvexity :: f Int
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (PolyhedronOptsInternal First)
  instance
    Semigroup (PolyhedronOptsInternal First)

deriving via
  Generically (PolyhedronOptsInternal First)
  instance
    Monoid (PolyhedronOptsInternal First)

instance HasPoints V3 PolyhedronOpts where
  points v = PolyhedronOpts $ mempty {polyhedronOptsPoints = First $ Just $ v}

instance HasFaces PolyhedronOpts where
  faces v = PolyhedronOpts $ mempty {polyhedronOptsFaces = First $ Just $ v}

instance HasConvexity PolyhedronOpts where
  convexity v = PolyhedronOpts $ mempty {polyhedronOptsConvexity = First $ Just v}

fallbackPolyhedronOpts :: PolyhedronOptsInternal Identity
fallbackPolyhedronOpts =
  PolyhedronOptsInternal
    { polyhedronOptsPoints = pure defaultPolyhedronPoints,
      polyhedronOptsFaces = pure defaultPolyhedronFaces,
      polyhedronOptsConvexity = pure defaultConvexity
    }

polyhedron :: (MonadNeon m) => PolyhedronOpts -> m Model3D
polyhedron (PolyhedronOpts optsMay) = do
  let opts :: PolyhedronOptsInternal Identity
      opts = bzipWith orDef fallbackPolyhedronOpts optsMay

  pure $
    Primitive3D $
      Polyhedron3D
        { polyhedronPoints = map tup $ get opts.polyhedronOptsPoints,
          polyhedronFaces = Just (map (\(a, b, c) -> [a, b, c]) (map tup $ get opts.polyhedronOptsFaces)),
          polyhedronConvexity = Just (get opts.polyhedronOptsConvexity)
        }

-------------------------------------------------------------------------------
-- / 2D-3D Conversion
-------------------------------------------------------------------------------

newtype ExtrudeLinearOpts = ExtrudeLinearOpts (ExtrudeLinearOptsInternal First)
  deriving newtype (Semigroup, Monoid)

data ExtrudeLinearOptsInternal f = ExtrudeLinearOptsInternal
  { extrudeLinearOptsHeight :: f Double,
    extrudeLinearOptsCenter :: f Bool,
    extrudeLinearOptsScaleFactor :: f Double,
    extrudeLinearOptsTwistAngle :: f Double,
    extrudeLinearOptsTwistSlices :: f (AutoOrSet Int)
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (ExtrudeLinearOptsInternal First)
  instance
    Semigroup (ExtrudeLinearOptsInternal First)

deriving via
  Generically (ExtrudeLinearOptsInternal First)
  instance
    Monoid (ExtrudeLinearOptsInternal First)

data AutoOrSet a = Auto | Set a

instance HasHeight ExtrudeLinearOpts where
  height v = ExtrudeLinearOpts $ mempty {extrudeLinearOptsHeight = First $ Just v}

instance IsCenter ExtrudeLinearOpts where
  center = ExtrudeLinearOpts $ mempty {extrudeLinearOptsCenter = First $ Just True}

scaleFactor :: Double -> ExtrudeLinearOptsInternal First
scaleFactor s = mempty {extrudeLinearOptsScaleFactor = First $ Just s}

fallbackExtrudeLinearOpts :: ExtrudeLinearOptsInternal Identity
fallbackExtrudeLinearOpts =
  ExtrudeLinearOptsInternal
    { extrudeLinearOptsHeight = pure defaultLength,
      extrudeLinearOptsCenter = pure False,
      extrudeLinearOptsScaleFactor = pure 1,
      extrudeLinearOptsTwistAngle = pure 0,
      extrudeLinearOptsTwistSlices = pure Auto
    }

twistAngle :: Double -> ExtrudeLinearOpts
twistAngle a = ExtrudeLinearOpts $ mempty {extrudeLinearOptsTwistAngle = First $ Just a}

twistSlices :: Int -> ExtrudeLinearOpts
twistSlices s = ExtrudeLinearOpts $ mempty {extrudeLinearOptsTwistSlices = First $ Just (Set s)}

twistSlicesAuto :: ExtrudeLinearOpts
twistSlicesAuto = ExtrudeLinearOpts $ mempty {extrudeLinearOptsTwistSlices = First $ Just Auto}

extrudeLinear :: (MonadNeon m) => ExtrudeLinearOpts -> m Model2D -> m Model3D
extrudeLinear (ExtrudeLinearOpts optsMay) modelM = do
  model <- modelM
  fc <- askFacets
  pure $
    Extrude3D
      ( LinearExtrude
          { linearHeight = get opts.extrudeLinearOptsHeight,
            linearCenter = spareFlag (get opts.extrudeLinearOptsCenter),
            linearTwist = spareOpt (get opts.extrudeLinearOptsTwistAngle) 0,
            linearScale = spareOpt (get opts.extrudeLinearOptsScaleFactor) 1,
            linearSlices = case get opts.extrudeLinearOptsTwistSlices of
              Set s -> Just s
              Auto -> Nothing,
            linearConvexity = Just defaultConvexity,
            linearFacets = Just fc
          }
      )
      [model]
  where
    opts :: ExtrudeLinearOptsInternal Identity
    opts = bzipWith orDef fallbackExtrudeLinearOpts optsMay

-------------------------------------------------------------------------------

data ExtrudeRotationalOpts f = ExtrudeRotationalOpts
  { extrudeRotationalOptsAngle :: f Double,
    extrudeRotationalOptsConvexity :: f Int,
    extrudeRotationalOptsFacets :: f Facets
  }
  deriving
    ( Generic,
      FunctorB,
      TraversableB,
      ApplicativeB,
      ConstraintsB
    )

deriving via
  Generically (ExtrudeRotationalOpts First)
  instance
    Semigroup (ExtrudeRotationalOpts First)

deriving via
  Generically (ExtrudeRotationalOpts First)
  instance
    Monoid (ExtrudeRotationalOpts First)

fallbackExtrudeRotationalOpts :: Facets -> ExtrudeRotationalOpts Identity
fallbackExtrudeRotationalOpts fc =
  ExtrudeRotationalOpts
    { extrudeRotationalOptsAngle = pure 360,
      extrudeRotationalOptsConvexity = pure defaultConvexity,
      extrudeRotationalOptsFacets = pure fc
    }

instance HasAngle (ExtrudeRotationalOpts First) where
  angle a = mempty {extrudeRotationalOptsAngle = First $ Just a}

extrudeRotational :: (MonadNeon m) => ExtrudeRotationalOpts First -> m Model2D -> m Model3D
extrudeRotational optsMay modelM = do
  model <- modelM
  fc <- askFacets

  let opts :: ExtrudeRotationalOpts Identity
      opts = bzipWith orDef (fallbackExtrudeRotationalOpts fc) optsMay

  pure $
    Extrude3D
      ( RotateExtrude
          { rotateAngle = get opts.extrudeRotationalOptsAngle,
            rotateConvexity = Just (get opts.extrudeRotationalOptsConvexity),
            rotateFacets = Just (get opts.extrudeRotationalOptsFacets)
          }
      )
      [model]

----

-- TODO: Implement
-- project :: (MonadNeon m) => m Model3D -> m Model2D
-- project = undefined

-------------------------------------------------------------------------------
-- / Helpers
-------------------------------------------------------------------------------

spareOpt :: (Eq a) => a -> a -> Maybe a
spareOpt x y = if x == y then Nothing else Just x

spareFlag :: Bool -> Maybe Bool
spareFlag b = spareOpt b False

orDef :: Identity a -> First a -> Identity a
orDef def opt = pure $ fromMaybe (runIdentity def) (getFirst opt)

get :: Identity a -> a
get = runIdentity

handlePlacement3 :: (MonadNeon m) => V3 Placement -> V3 Placement -> V3 Double -> m Model3D -> m Model3D
handlePlacement3 (V3 defX defY defZ) (V3 pX pY pZ) (V3 x y z) =
  moveXYZ $
    V3
      (handlePlacement defX pX x)
      (handlePlacement defY pY y)
      (handlePlacement defZ pZ z)

handlePlacement2 :: (MonadNeon m) => V2 Placement -> V2 Placement -> V2 Double -> m Model2D -> m Model2D
handlePlacement2 (V2 defX defY) (V2 pX pY) (V2 x y) =
  moveXY
    ( V2
        (handlePlacement defX pX x)
        (handlePlacement defY pY y)
    )

handlePlacement :: Placement -> Placement -> Double -> Double
handlePlacement def p x = case (def, p) of
  (PlacementCenter, PlacementCenter) -> 0
  (PlacementCenter, PlacementOrigin) -> x / 2
  (PlacementOrigin, PlacementCenter) -> -x / 2
  (PlacementOrigin, PlacementOrigin) -> 0

-------------------------------------------------------------------------------
-- / Rendering
-------------------------------------------------------------------------------

render2D :: NeonM Model2D -> String
render2D = O.render2D . runNeonM defaultFacets

render3D :: NeonM Model3D -> String
render3D = O.render3D . runNeonM defaultFacets

-------------------------------------------------------------------------------

class HasHeight a where
  height :: Double -> a

class HasDiameter a where
  diameter :: Double -> a

class HasPoints v a | a -> v where
  points :: [v Double] -> a

class HasSize o a | a -> o where
  size :: o -> a

class HasFaces a where
  faces :: [V3 Int] -> a

class HasCount a where
  count :: Int -> a

class HasMaxSize o a | a -> o where
  maxSize :: o -> a

class HasMaxAngle a where
  maxAngle :: Double -> a

class HasConvexity a where
  convexity :: Int -> a

class HasAngle a where
  angle :: Double -> a

class HasPlacementX a where
  placeX :: Placement -> a

class HasPlacementY a where
  placeY :: Placement -> a

class HasPlacementZ a where
  placeZ :: Placement -> a

class HasDiameterTop a where
  diameterTop :: Double -> a

class HasDiameterBottom a where
  diameterBottom :: Double -> a

class HasFacets a where
  facets :: Facets -> a

-------------------------------------------------------------------------------

class CanMoveXYZ a where
  moveXYZ :: V3 Double -> a -> a

moveBackXYZ :: (CanMoveXYZ a) => V3 Double -> a -> a
moveBackXYZ v model = moveXYZ (fmap negate v) model

withMoveXYZ :: (CanMoveXYZ a) => V3 Double -> (a -> a) -> a -> a
withMoveXYZ v f = moveBackXYZ v . f . moveXYZ v

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

class CanColoring a where
  color :: ColorOpts First -> a -> a

class CanHull a where
  hull :: a -> a

class CanUnion a where
  union :: a -> a -> a
  unions :: [a] -> a

class CanIntersection a where
  intersection :: a -> a -> a
  intersections :: [a] -> a

class CanDifference a where
  difference :: a -> a -> a
  differences :: a -> [a] -> a

class CanMod a where
  mod :: Modifier -> a -> a

class CanComment a where
  comment :: String -> a -> a

-------------------------------------------------------------------------------

class IsLeft a where
  left :: a

class IsRight a where
  right :: a

class IsCenter a where
  center :: a

class IsOrigin a where
  origin :: a

-------------------------------------------------------------------------------

class VecTup t a | a -> t where
  vec :: t -> a
  tup :: a -> t

instance VecTup (a, a, a) (V3 a) where
  vec (x, y, z) = V3 x y z
  tup (V3 x y z) = (x, y, z)

instance VecTup (a, a) (V2 a) where
  vec (x, y) = V2 x y
  tup (V2 x y) = (x, y)