{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleContexts #-}
module NeonCAD where

import OpenSCAD.Model


type M = GlobalOpts -> Model3D


data GlobalOpts = GlobalOpts {
    defaultSize :: Double
}

---

type Diameter = Double
type Radius = Double


data Radial = Radius Double | Diameter Double


type MkOpts a = a -> a

class Monad m => C m where
    getGlobalOpts :: m GlobalOpts


class ToModel2D a m where
    toModel2D :: a -> m Model2D


newtype Convexity = Convexity Int

-------------------------------------------------------------------------------
-- 2D / Circle
-------------------------------------------------------------------------------

data Circle = Circle {
  size :: Radial,
  facets :: Maybe Facets
}

instance ToModel2D Circle m where
    toModel2D = undefined

defaultCircle :: Circle
defaultCircle = Circle {
  size = Diameter 100,
  facets = Nothing
}

circle :: Radial -> m Model2D
circle = undefined

circleR :: Double -> m Model2D
circleR = undefined

circleD :: Double -> m Model2D
circleD = undefined

circleR' :: Double -> Facets -> m Model2D
circleR' = undefined

circleD' :: Double -> Facets -> m Model2D
circleD' = undefined

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

mkProjection :: Projection -> m Model2D
mkProjection = undefined

mkProjection' :: C m => MkOpts Projection -> m Model2D
mkProjection' = undefined

projection :: [m Model3D] -> m Model2D
projection = undefined

projectionCut :: [m Model3D] -> m Model2D
projectionCut = undefined


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
