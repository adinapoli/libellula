{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Data.ByteString (ByteString)
import qualified Data.Text as T
import qualified Data.Map as Map
import           Snap.Core
import           Snap.Snaplet

------------------------------------------------------------------------------
import           Application
import           Handlers

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/serve-command", with libellula handleServeCommand)
         ]

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "The libellula application." Nothing $ do
    addRoutes routes
    l <- nestSnaplet "libellula" libellula libellulaInit
    return $ App l

libellulaInit :: SnapletInit App LibellulaCtx
libellulaInit = makeSnaplet "libellula" "The Cxt" Nothing $ do
  return $ LibellulaCtx Map.empty
