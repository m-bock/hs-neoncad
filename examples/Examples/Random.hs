module Examples.Random where

-- import Control.Monad.State.Strict

import Control.Monad (replicateM)
import Control.Monad.Trans.State.Strict (State, StateT, evalState, state)
import Data.Traversable (for)
import NeonCAD
import NeonCAD.ToolBox
import System.Environment (getEnv)
import System.Random

class (Monad m) => MonadGen m where
  uniformM :: (Uniform a) => m a
  uniformRM :: (UniformRange a) => (a, a) -> m a

drawPile :: forall m. (MonadNeon m, MonadGen m) => m Model3D
drawPile =
  fmap unions $ for [0 .. 20] $ \i -> do
    angleZ <- uniformRM (0, 360)
    l <- uniformRM (80, 100)
    h <- uniformRM (10, 30)
    moveZ (fromIntegral i * 10) $
      spinZ angleZ $
        box $
          placeZ origin <> size (V3 l l h)

example :: forall m. (MonadNeon m, MonadGen m) => m Model3D
example = do
  difference
    drawPile
    (cylinder $ diameter 80 <> height 1000)

newtype M a = M (NeonT (State StdGen) a)
  deriving newtype (Functor, Applicative, Monad, MonadNeon)

instance MonadGen M where
  uniformM = M $ liftNeonT (state uniform)
  uniformRM r = M $ liftNeonT (state (uniformR r))

run :: Int -> M Model3D -> Model3D
run seed (M m) = evalState (runNeonT defaultFacets m) (mkStdGen seed)

main :: IO ()
main = do
  docImgsPath <- getEnv "EXAMPLES_DIR"
  writeFile
    (docImgsPath ++ "/scad/random.scad")
    (renderModel3D $ run 42 example)