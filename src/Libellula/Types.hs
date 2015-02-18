
module Libellula.Types where

import qualified Data.Map as Map
import qualified Data.Text as T
import Control.Monad.Trans.Reader

data LibellulaTree m = Leaf (LibellulaM m)
                     | Node (Map.Map T.Text (LibellulaM m))
-- NOTE: What if I want to go crazy with nesting?

type LibellulaCommands m = Map.Map T.Text (LibellulaTree m)

data LibellulaEnv m = LibellulaEnv {
      _lib_cmds :: LibellulaCommands m
     }

type LibellulaAction = LibellulaM IO

newtype LibellulaM m = LibellulaM { runLibellula :: ReaderT (LibellulaEnv m) m () }
