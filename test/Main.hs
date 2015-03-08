{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
module Main where

import           Test.Tasty
import           Test.Tasty.HUnit
import           Test.Tasty.QuickCheck
import           Test.QuickCheck.Monadic
import           Tests
import qualified Data.Text as T


--------------------------------------------------------------------------------
main :: IO ()
main = defaultMain allTests


--------------------------------------------------------------------------------
withQuickCheckDepth :: TestName -> Int -> [TestTree] -> TestTree
withQuickCheckDepth tn depth tests =
  localOption (QuickCheckTests depth) (testGroup tn tests)

cmdMap :: [(T.Text, ())]
cmdMap = map (, ()) ["tmux go", "jump", "low", "up", "eek", "caml", "dashify"]

--------------------------------------------------------------------------------
allTests :: TestTree
allTests = testGroup "All Tests" [
    testGroup "Parser tests" [
        testCase "tmux go 2" test1
    ]
  ]
