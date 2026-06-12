module DocImgs where

import Data.Foldable (for_)
import NeonCAD
import System.Environment (getEnv)

info3D :: (MonadNeon m) => [(String, m Model3D)]
info3D =
  [ ("box", box mempty),
    ("cube", cube mempty),
    ("sphere", sphere mempty),
    ("ellipsoid", ellipsoid mempty),
    ("cylinder", cylinder mempty),
    ("polyhedron", polyhedron mempty),
    ("frustum", frustum mempty)
  ]

info2D :: (MonadNeon m) => [(String, m Model2D)]
info2D =
  [ ("text", text "Hello, World!" mempty),
    ("rect", rect mempty),
    ("square", square mempty),
    ("polygon", polygon mempty),
    ("ellipse", ellipse mempty),
    ("circle", circle mempty)
  ]

main :: IO ()
main = do
  docImgsPath <- getEnv "DOC_IMGS_DIR"

  for_ info3D $ \(name, model) -> do
    writeFile
      (docImgsPath ++ "/" ++ name ++ ".scad")
      (render3D model)

  for_ info2D $ \(name, model) -> do
    writeFile
      (docImgsPath ++ "/" ++ name ++ ".scad")
      (render2D model)
