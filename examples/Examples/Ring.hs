module Examples.Ring where

import Examples.Util.Generic (FirstUnlessDefault (..), SemigroupPlus (..))
import GHC.Generics (Generic)
import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)

class HasInnerDiameter a where
  innerDiameter :: Double -> a

class HasOuterDiameter a where
  outerDiameter :: Double -> a

-------------------------------------------------------------------------------

data DrawRingOpts = DrawRingOpts
  { innerDiameter :: Double,
    outerDiameter :: Double,
    height :: Double
  }
  deriving (Eq, Generic)
  deriving (Semigroup) via (SemigroupPlus DrawRingOpts)

instance Monoid DrawRingOpts where
  mempty =
    DrawRingOpts
      { innerDiameter = 80,
        outerDiameter = 100,
        height = 0
      }

instance HasHeight DrawRingOpts where
  height v = mempty {height = v}

instance HasInnerDiameter DrawRingOpts where
  innerDiameter v = mempty {innerDiameter = v}

instance HasOuterDiameter DrawRingOpts where
  outerDiameter v = mempty {outerDiameter = v}

drawRing :: (MonadNeon m) => DrawRingOpts -> m Model3D
drawRing opts =
  comment "ring" $
    difference
      ( comment "outer" $
          cylinder $
            diameter diaOuter <> height h
      )
      ( comment "inner" $
          cylinder $
            diameter diaInner <> height (h + eps * 2)
      )
  where
    diaInner = opts.innerDiameter
    diaOuter = opts.outerDiameter
    h = opts.height

-------------------------------------------------------------------------------

example :: (MonadNeon m) => m Model3D
example =
  drawRing $
    height 3.0 <> outerDiameter 60.0 <> innerDiameter 50.0

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/ring.scad")
    (render3D example)
