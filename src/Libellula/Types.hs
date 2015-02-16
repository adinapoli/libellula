
module Libellula.Types where

import qualified Data.Map as Map
import qualified Data.Text as T
import Control.Monad.Trans.State.Strict

data LibellulaEnv  = LibellulaEnv {
      _lib_cmds :: Map.Map T.Text LibellulaAction
     }

type LibellulaAction = LibellulaM ()

newtype LibellulaM a = LibellulaM { runLibellula :: StateT LibellulaEnv IO a }
