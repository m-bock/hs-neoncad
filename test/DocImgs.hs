module DocImgs where

import Data.Foldable (for_)
import NeonCAD

info :: (MonadNeon m) => [(String, m Model3D)]
info =
    [ ("box", box mempty)
    , ("cube", cube mempty)
    , ("sphere", sphere mempty)
    , ("ellipsoid", ellipsoid mempty)
    , ("cylinder", cylinder mempty)
    , ("polyhedron", polyhedron mempty)
    ]

main :: IO ()
main = do
    for_ info $ \(name, model) -> do
        writeFile
            ("out/doc-imgs/" ++ name ++ ".scad")
            (render3D $ run model)
