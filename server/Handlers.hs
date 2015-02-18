{-# LANGUAGE ScopedTypeVariables #-}
module Handlers where

import Snap
import Snap.Snaplet
import Extras
import Application

handleServeCommand :: Handler App LibellulaCtx ()
handleServeCommand = do
  (cmd :: LibellulaCommand) <- reqJSON
  liftIO $ print cmd
  writeText (command cmd)
