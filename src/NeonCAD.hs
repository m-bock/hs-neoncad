{- FOURMOLU_DISABLE -}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

module NeonCAD (
  comment,
  render2D, render3D,

  -- 2D / Primitive
  circleR, circleD,
  ellipseR, ellipseD,
  rect, rectCenter,
  square, squareCenter,
  polygon,
  text, defaultTextOpts, TextOpts, FontName, FontStyle,
  

  -- 3D / Primitive
  box, boxCenter,
  cube, cubeCenter,

  -- Transform
  union, intersection, difference,
  scaleXY, scaleX, scaleY, scaleXZ, scaleYZ, scaleXYZ,
  resizeXY, resizeX, resizeY,
  moveXYZ, moveXY, moveXZ, moveYZ, moveX, moveY, moveZ,
  rotateZ,
  mirrorXY, mirrorX, mirrorY,
  colorRGB, colorRGBA, color,
  hull,
  extrudeLinear,
  
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

import OpenSCAD.Model
  ( Model2D(..), Primitive2D(..), Transform2D(..)
  , Model3D(..), Primitive3D(..), Transform3D(..)
  , Direction(..), HorizontalAlignment(..), VerticalAlignment(..)
  , Modifier(..)
  , Extrude3D(..)
  , V2, V3
  , Facets(..), Font(..)
  , render2D, render3D
  )
import Data.Functor.Identity (Identity (runIdentity))

-------------------------------------------------------------------------------
-- / Types
-------------------------------------------------------------------------------

data Radial = Radius Double | Diameter Double

data ResizeOp = Auto | Keep | Set Double

-------------------------------------------------------------------------------
-- / Monad
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
-- / Factes
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

class ToModel2D a m where
    toModel2D :: a -> m Model2D

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

-------------------------------------------------------------------------------
-- / Classes / Move
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

-------------------------------------------------------------------------------
-- / Classes / Resize
-------------------------------------------------------------------------------

class ResizeXYZ a m where
  resizeXYZ :: V3 Double -> m a -> m a

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
-- / Classes / Rotate
-------------------------------------------------------------------------------

class RotateX a m where
  rotateX :: Double -> m a -> m a

class RotateY a m where
  rotateY :: Double -> m a -> m a

class RotateZ a m where
  rotateZ :: Double -> m a -> m a

-- TODO

-------------------------------------------------------------------------------
-- / Classes / Mirror
-------------------------------------------------------------------------------

class MirrorXY a m where
  mirrorXY :: V2 Double -> m a -> m a

class MirrorX a m where
  mirrorX :: m a -> m a

class MirrorY a m where
  mirrorY :: m a -> m a

-------------------------------------------------------------------------------
-- / Classes / Color
-------------------------------------------------------------------------------

class Color a m where
  color :: V3 Double -> Maybe Double -> m a -> m a

class ColorRGB a m where
  colorRGB :: V3 Double -> m a -> m a

class ColorRGBA a m where
  colorRGBA :: V3 Double -> Double -> m a -> m a

-------------------------------------------------------------------------------
-- / Classes / Hull
-------------------------------------------------------------------------------

class Hull a m where
  hull :: [m a] -> m a

-------------------------------------------------------------------------------
-- / Classes / Union
-------------------------------------------------------------------------------

class Union a m where
  union :: [m a] -> m a

-------------------------------------------------------------------------------
-- / Classes / Intersection
-------------------------------------------------------------------------------

class Intersection a m where
  intersection :: [m a] -> m a

-------------------------------------------------------------------------------
-- / Classes / Difference
-------------------------------------------------------------------------------

class Difference a m where
  difference :: m a -> m a -> m a

-------------------------------------------------------------------------------
-- / Classes / Modifiers
-------------------------------------------------------------------------------

class Modifiers a m where
  modDisable :: m a -> m a
  modShowOnly :: m a -> m a
  modHighlight :: m a -> m a
  modTransparent :: m a -> m a

-------------------------------------------------------------------------------
-- / 2D / Comment
-------------------------------------------------------------------------------

comment :: (MonadNeon m) => String -> m Model2D -> m Model2D
comment text modelM = do
  model <- modelM
  pure $ Comment2D text model

-------------------------------------------------------------------------------
-- / 2D / Modifiers
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- / 2D / Primitive / Circle
-------------------------------------------------------------------------------

data Circle = Circle {
  size :: Radial
}

instance MonadNeon m => ToModel2D Circle m where
    toModel2D (Circle {size}) = do
      facets <- askFacets
      pure $ Primitive2D $ Circle2D
        { circleDiameter = radialToDiameter size
        , circleFacets   = Just facets
        }

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
-- / 2D / Primitive / Ellipse
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
-- / 2D / Primitive / Rect
-------------------------------------------------------------------------------

data Rect = Rect {
  size :: V2 Double,
  center :: Bool
}

instance MonadNeon m => ToModel2D Rect m where
  toModel2D (Rect {size, center}) = pure $
    Primitive2D $ Square2D
      { squareSize   = size
      , squareCenter = spareFlag center
      }

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
-- / 2D / Primitive / Square
-------------------------------------------------------------------------------

data Square = Square {
  size :: Double,
  center :: Bool
}

instance MonadNeon m => ToModel2D Square m where
  toModel2D (Square {size, center}) = pure $
    Primitive2D $ Square2D
      { squareSize   = (size, size)
      , squareCenter = spareFlag center
      }

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
-- / 2D / Primitive / Polygon
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
    Primitive2D $ Polygon2D
      { polygonPoints    = points
      , polygonPaths     = Nothing
      , polygonConvexity = Just convexity
      }

polygon :: MonadNeon m => [V2 Double] -> m Model2D
polygon points = toModel2D $ Polygon { points = points, convexity = defaultConvexity }


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

text :: MonadNeon m => String -> TextOpts -> m Model2D
text txt opts = do
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

-------------------------------------------------------------------------------
-- / 2D / Transform / Scale
-------------------------------------------------------------------------------

instance MonadNeon m => ScaleXY Model2D m where
  scaleXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D Scale2D {scaleVector = (x, y)} [model]

instance MonadNeon m => ScaleX Model2D m where
  scaleX x modelM = scaleXY (x, 1) modelM

instance MonadNeon m => ScaleY Model2D m where
  scaleY y modelM = scaleXY (1, y) modelM

-------------------------------------------------------------------------------
-- / 2D / Transform / Resize
-------------------------------------------------------------------------------

resize2D :: MonadNeon m => V2 ResizeOp -> m Model2D -> m Model2D
resize2D (x, y) modelM = do
  model <- modelM
  let (valX, autoX) = getValueAndAuto x
      (valY, autoY) = getValueAndAuto y
      auto =
        case (autoX, autoY) of
          (False, False) -> Nothing
          _ -> Just (autoX, autoY)
  pure $ Transform2D Resize2D
    { resizeNewSize = (valX, valY)
    , resizeAuto = auto
    }
    [model]

instance MonadNeon m => ResizeXY Model2D m where
  resizeXY (x, y) modelM = resize2D (Set x, Set y) modelM

instance MonadNeon m => ResizeX Model2D m where
  resizeX x modelM = resize2D (Set x, Keep) modelM

instance MonadNeon m => ResizeY Model2D m where
  resizeY y modelM = resize2D (Keep, Set y) modelM

instance MonadNeon m => ResizeAutoX Model2D m where
  resizeAutoX val modelM = resize2D (Set val, Auto) modelM

instance MonadNeon m => ResizeAutoY Model2D m where
  resizeAutoY val modelM = resize2D (Auto, Set val) modelM

-------------------------------------------------------------------------------
-- / 2D / Transform / Rotate
-------------------------------------------------------------------------------

instance MonadNeon m => RotateZ Model2D m where
  rotateZ angle modelM = do
    model <- modelM
    pure $ Transform2D RotateAxis2D
      { rotateAxisAngle  = angle
      , rotateAxisVector = Nothing
      }
      [model]

-------------------------------------------------------------------------------
-- / 2D / Transform / Move
-------------------------------------------------------------------------------

instance MonadNeon m => MoveXYZ Model2D m where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform2D (Translate2D v) [model]

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
-- / 2D / Transform / Mirror
-------------------------------------------------------------------------------

instance MonadNeon m => MirrorXY Model2D m where
  mirrorXY (x, y) modelM = do
    model <- modelM
    pure $ Transform2D Mirror2D {mirrorVector = (x, y)} [model]

instance MonadNeon m => MirrorX Model2D m where
  mirrorX modelM = mirrorXY (1, 0) modelM

instance MonadNeon m => MirrorY Model2D m where
  mirrorY modelM = mirrorXY (0, 1) modelM

-------------------------------------------------------------------------------
-- / 2D / Transform / Color
-------------------------------------------------------------------------------

instance MonadNeon m => Color Model2D m where
  color c a modelM = do
    model <- modelM
    pure $ Transform2D Color2D 
      { colorColor = c
      , colorAlpha = a
      }
      [model]

instance MonadNeon m => ColorRGB Model2D m where
  colorRGB c modelM = color c Nothing modelM

instance MonadNeon m => ColorRGBA Model2D m where
  colorRGBA c a modelM = color c (Just a) modelM

-------------------------------------------------------------------------------
-- / 2D / Transform / Offset
-------------------------------------------------------------------------------

offset :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offset = undefined

offsetRound :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offsetRound = undefined

offsetCut :: (MonadNeon m) => Double -> m Model2D -> m Model2D
offsetCut = undefined

-------------------------------------------------------------------------------
-- / 2D / Transform / Hull
-------------------------------------------------------------------------------

instance MonadNeon m => Hull Model2D m where
  hull modelsM = do
    models <- sequence modelsM
    pure $ Transform2D Hull2D models

-------------------------------------------------------------------------------
-- / 2D / Transform / Union
-------------------------------------------------------------------------------

instance MonadNeon m => Union Model2D m where
  union modelsM = do
    models <- sequence modelsM
    pure $ Transform2D Union2D models

-------------------------------------------------------------------------------
-- / 2D / Transform / Intersection
-------------------------------------------------------------------------------

instance MonadNeon m => Intersection Model2D m where
  intersection modelsM = do
    models <- sequence modelsM
    pure $ Transform2D Intersection2D models

-------------------------------------------------------------------------------
-- / 2D / Transform / Difference
-------------------------------------------------------------------------------

instance MonadNeon m => Difference Model2D m where
  difference modelAM modelBM = do
    modelA <- modelAM
    modelB <- modelBM
    pure $ Transform2D Difference2D [modelA, modelB]

-------------------------------------------------------------------------------
-- / 2D / Extrude / Rotational
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Comment
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Modifiers
-------------------------------------------------------------------------------

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
-- / 3D / Transform / Scale 
-------------------------------------------------------------------------------

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

instance MonadNeon m => ScaleZ Model3D m where
  scaleZ z modelM = scaleXYZ (1, 1, z) modelM

-------------------------------------------------------------------------------
-- / 3D / Transform / Resize
-------------------------------------------------------------------------------

resize3D :: MonadNeon m => V3 ResizeOp -> m Model3D -> m Model3D
resize3D (x, y, z) modelM = do
  model <- modelM
  let (valX, autoX) = getValueAndAuto x
      (valY, autoY) = getValueAndAuto y
      (valZ, autoZ) = getValueAndAuto z
  pure $ Transform3D Resize3D
    { resizeNewSize = (valX, valY, valZ)
    , resizeAuto = Just (autoX, autoY, autoZ)
    }
    [model]

instance MonadNeon m => ResizeXYZ Model3D m where
  resizeXYZ (x, y, z) modelM = resize3D (Set x, Set y, Set z) modelM

-------------------------------------------------------------------------------
-- / 3D / Transform / Rotate
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Transform / Move
-------------------------------------------------------------------------------

instance MonadNeon m => MoveXYZ Model3D m where
  moveXYZ v modelM = do
    model <- modelM
    pure $ Transform3D (Translate3D v) [model]

instance MonadNeon m => MoveXY Model3D m where
  moveXY (x, y) modelsM = moveXYZ (x, y, 0) modelsM

instance MonadNeon m => MoveXZ Model3D m where
  moveXZ (x, z) modelsM = moveXYZ (x, 0, z) modelsM

instance MonadNeon m => MoveYZ Model3D m where
  moveYZ (y, z) modelsM = moveXYZ (0, y, z) modelsM

instance MonadNeon m => MoveX Model3D m where
  moveX x modelsM = moveXYZ (x, 0, 0) modelsM

instance MonadNeon m => MoveY Model3D m where
  moveY y modelsM = moveXYZ (0, y, 0) modelsM

instance MonadNeon m => MoveZ Model3D m where
  moveZ z modelsM = moveXYZ (0, 0, z) modelsM

-------------------------------------------------------------------------------
-- / 3D / Transform / Mirror
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- /3D / Transform / Color
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Transform / Union
-------------------------------------------------------------------------------

instance MonadNeon m => Union Model3D m where
  union modelsM = do
    models <- sequence modelsM
    pure $ Transform3D Union3D models

-------------------------------------------------------------------------------
-- / 3D / Transform / Intersection
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Transform / Difference
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 3D / Transform / Hull
-------------------------------------------------------------------------------

-- TODO: Implement

-------------------------------------------------------------------------------
-- / 2D-3D Conversion
-------------------------------------------------------------------------------

extrudeLinear :: (MonadNeon m) => Double -> m Model2D -> m Model3D
extrudeLinear height = extrudeLineaWith height noScale noTwist


extrudeLineaWith :: (MonadNeon m) => Double -> Scale -> Twist -> m Model2D -> m Model3D
extrudeLineaWith height scale twist modelM = do
  model <- modelM
  facets <- askFacets
  pure $ Extrude3D (LinearExtrude
    { linearHeight    = height
    , linearCenter    = Nothing
    , linearTwist     = case twist of
        NoTwist -> Nothing
        Twist a _ -> Just a
    , linearScale     = case scale of
        NoScale -> Nothing
        Scale s -> Just s
    , linearSlices    = case twist of
        Twist _ (Just s) -> Just s
        _ -> Nothing
    , linearConvexity = Just defaultConvexity
    , linearFacets    = Just facets
  }) [model]

data Scale = NoScale | Scale Double

noScale :: Scale
noScale = NoScale

scale :: Double -> Scale
scale s = Scale s

noTwist :: Twist
noTwist = NoTwist

twist :: Double -> Twist
twist t = Twist t Nothing

twistWithSlices :: Double -> Int -> Twist
twistWithSlices a s = Twist a (Just s)

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

radialToDiameter :: Radial -> Double
radialToDiameter (Radius r)   = r * 2
radialToDiameter (Diameter d) = d

getValueAndAuto :: ResizeOp -> (Double, Bool)
getValueAndAuto op = case op of
  Auto  -> (0, True)
  Keep  -> (0, False)
  Set d -> (d, False)

spareOpt :: Eq a => a -> a -> Maybe a
spareOpt x y = if x == y then Nothing else Just x

spareFlag :: Bool -> Maybe Bool
spareFlag b = spareOpt b False
