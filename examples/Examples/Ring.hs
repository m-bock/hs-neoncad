module Examples.Ring where

import Examples.Util.Generic (FirstUnlessDefault (..))
import GHC.Generics (Generic)
import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)

---

data DrawRingOpts = DrawRingOpts
  { drawRingOptsInnerDiameter :: Double,
    drawRingOptsOuterDiameter :: Double,
    drawRingOptsHeight :: Double
  }
  deriving (Eq, Generic)
  deriving (Semigroup) via (FirstUnlessDefault DrawRingOpts)

instance Monoid DrawRingOpts where
  mempty =
    DrawRingOpts
      { drawRingOptsInnerDiameter = 80,
        drawRingOptsOuterDiameter = 100,
        drawRingOptsHeight = 0
      }

instance HasHeight DrawRingOpts where
  height v = mempty {drawRingOptsHeight = v}

instance HasInnerDiameter Double DrawRingOpts where
  innerDiameter v = mempty {drawRingOptsInnerDiameter = v}

instance HasOuterDiameter Double DrawRingOpts where
  outerDiameter v = mempty {drawRingOptsOuterDiameter = v}

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
    diaInner = opts.drawRingOptsInnerDiameter
    diaOuter = opts.drawRingOptsOuterDiameter
    h = opts.drawRingOptsHeight

---

class HasInnerDiameter o a | a -> o where
  innerDiameter :: o -> a

class HasOuterDiameter o a | a -> o where
  outerDiameter :: o -> a

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
