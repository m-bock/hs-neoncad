{-# LANGUAGE BlockArguments #-}

module Examples.PencilHolder where

import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)
import Prelude hiding (mod)

example :: (MonadNeon m) => m Model3D
example = box mempty

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/scad/pencil-holder.scad")
    (render3D example)
