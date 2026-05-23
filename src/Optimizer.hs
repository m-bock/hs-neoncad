{- FOURMOLU_DISABLE -}

module Optimizer where

import OpenSCAD

x :: Model3D
x = undefined

t = BoolOp3D Union3D [x, BoolOp3D Union3D [x, BoolOp3D Union3D [x,BoolOp3D Union3D []]]]

optimize3D :: Model3D -> Model3D
optimize3D mod = case mod of
    BoolOp3D Union3D [x, y] -> case optimize3D y of
        BoolOp3D Union3D xs -> BoolOp3D Union3D ([optimize3D x] <> xs)
        y' -> BoolOp3D Union3D [optimize3D x, y']

    BoolOp3D Intersection3D [x, y] -> case optimize3D y of
        BoolOp3D Intersection3D xs -> BoolOp3D Intersection3D ([optimize3D x] <> xs)
        y' -> BoolOp3D Intersection3D [optimize3D x, y']



    Primitive3D primitive      -> Primitive3D primitive
    Transform3D t1 kids       -> Transform3D t1 (map optimize3D kids)
    BoolOp3D op kids           -> BoolOp3D op (map optimize3D kids)
    Extrude3D e kids           -> Extrude3D e (map optimize2D kids)
    Comment3D comment ast      -> Comment3D comment (optimize3D ast)
    Modifier3D modifier ast    -> Modifier3D modifier (optimize3D ast)

optimize2D :: Model2D -> Model2D
optimize2D mod = case mod of
    BoolOp2D Union2D [x, y] -> case optimize2D y of
        BoolOp2D Union2D xs -> BoolOp2D Union2D ([optimize2D x] <> xs)
        y' -> BoolOp2D Union2D [optimize2D x, y']

    BoolOp2D Intersection2D [x, y] -> case optimize2D y of
        BoolOp2D Intersection2D xs -> BoolOp2D Intersection2D ([optimize2D x] <> xs)
        y' -> BoolOp2D Intersection2D [optimize2D x, y']

    Primitive2D primitive      -> Primitive2D primitive
    Transform2D t1 kids       -> Transform2D t1 (map optimize2D kids)
    BoolOp2D op kids           -> BoolOp2D op (map optimize2D kids)
    Projection2D projection kids -> Projection2D projection (map optimize3D kids)
    Comment2D comment ast      -> Comment2D comment (optimize2D ast)
    Modifier2D modifier ast    -> Modifier2D modifier (optimize2D ast)

--     Transform3D t1 kids   -> Transform3D t1 $ case map optimize3D' kids of
--         [] -> []
--     x -> x

-- optimize3D :: Model3D -> Model3D
-- optimize3D = \case
--     Transform3D t1 [BoolOp3D Union3D ch]   -> optimize3D $ Transform3D t1 ch
--     BoolOp3D Union3D [BoolOp3D Union3D ch] -> optimize3D $ BoolOp3D Union3D (map optimize3D ch)
--     Extrude3D e [BoolOp2D Union2D ch]      -> optimize3D $ Extrude3D e (map optimize2D ch)
    
--     Primitive3D primitive      -> Primitive3D primitive
--     Transform3D t1 ch          -> Transform3D t1 (map optimize3D ch)
--     BoolOp3D op children       -> BoolOp3D op (map optimize3D children)
--     Extrude3D extrude children -> Extrude3D extrude (map optimize2D children)
--     Comment3D comment ast      -> Comment3D comment (optimize3D ast)
--     Modifier3D modifier ast    -> Modifier3D modifier (optimize3D ast)




-- optimize2D :: Model2D -> Model2D
-- optimize2D = \case
--     Transform2D t [BoolOp2D Union2D ch]           -> optimize2D $ Transform2D t ch
--     BoolOp2D Union2D [BoolOp2D Union2D ch]        -> optimize2D $ BoolOp2D Union2D (map optimize2D ch)
--     Projection2D projection [BoolOp3D Union3D ch] -> optimize2D $ Projection2D projection (map optimize3D ch)

--     Primitive2D primitive            -> Primitive2D primitive    
--     Transform2D transform children   -> Transform2D transform (map optimize2D children)
--     BoolOp2D op children             -> BoolOp2D op (map optimize2D children)
--     Projection2D projection children -> Projection2D projection (map optimize3D children)
--     Comment2D comment ast            -> Comment2D comment (optimize2D ast)
--     Modifier2D modifier ast          -> Modifier2D modifier (optimize2D ast)

