{-# LANGUAGE TemplateHaskell #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import Control.Lens
import Snap.Snaplet
import qualified Data.Map as Map
import  Data.Aeson.TH
import qualified Data.Text as T

newtype LibellulaCommand = LibellulaCommand {
      command :: T.Text
    } deriving (Show)

deriveJSON defaultOptions ''LibellulaCommand

------------------------------------------------------------------------------
data LibellulaAction
data LibellulaCtx = LibellulaCtx (Map.Map T.Text LibellulaAction)

------------------------------------------------------------------------------
data App = App
    { _libellula :: Snaplet LibellulaCtx
    }

makeLenses ''App

------------------------------------------------------------------------------
type AppHandler = Handler App App
