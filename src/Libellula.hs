
module Libellula (
    module Libellula.Numerals
  , module Libellula.Types
  , on
  ) where

import Libellula.Numerals
import Libellula.Types

import qualified Data.Text as T

on :: T.Text -> ([T.Text] -> IO ()) -> IO ()
on rawText = \_ -> return ()
