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
  Model2D, Model3D,
  MonadNeon,

  -- * 3D Primitives
  -- ** Box
  -- *** Create
  -- |
  -- A box with separate x, y, and z sizes.
  -- Example:
  --
  -- >>> :{
  -- render3D $
  --   box (size (10, 20, 30) <> placement center)
  -- :}
  --
  -- ![box](out/doc-imgs/box.png)
  --
  box, 
  -- *** Options
  BoxOpts,

  -- ** Cube
  -- |
  -- A cube with equal sides.
  --
  -- ![cube](out/doc-imgs/cube.png)
  cube, CubeOpts,

  -- ** Sphere
  -- |
  -- Sized by diameter.
  --
  -- ![sphere](out/doc-imgs/sphere.png)
  sphere, SphereOpts,

  -- ** Ellipsoid
  -- |
  -- Sized separately on each axis.
  --
  -- ![ellipsoid](out/doc-imgs/ellipsoid.png)
  ellipsoid, EllipsoidOpts,

  -- ** Cylinder
  -- |
  -- Sized by height and diameter.
  --
  -- ![cylinder](out/doc-imgs/cylinder.png)
  cylinder, CylinderOpts,

  -- ** Polyhedron
  -- |
  -- A polyhedron from points and faces.
  --
  -- ![polyhedron](out/doc-imgs/polyhedron.png)
  polyhedron, PolyhedronOpts,

  -- * Attributes
  -- | Hello
  HasSize(..),
  HasPlacement(..),
  HasFacets(..),
  HasDiameter(..),
  HasFaces(..),
  HasConvexity(..),
  HasPoints(..),

  -- * Facts
  IsCenter(..),
  IsOrigin(..),

  -- * Modifiers
  MoveXYZ(..),
  MoveXY(..),
  MoveXZ(..),
  MoveYZ(..),
  MoveX(..),
  MoveY(..),
  MoveZ(..),

  -- * Tmp
  unions, moveX

  -- comment,
) where
stub = 0
