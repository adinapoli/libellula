module Lib
    ( someFunc
    ) where

import Atlas.Types.Model
import Test.QuickCheck

randomUser :: IO User
randomUser = do
  generate arbitrary

someFunc :: IO ()
someFunc = randomUser >>= print
