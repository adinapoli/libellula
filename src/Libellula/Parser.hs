{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Libellula.Parser where

import Prelude hiding (lookup)
import qualified Data.List as List
import Data.Char
import Data.Attoparsec.Text
import Libellula.AST
import Data.Monoid
import Control.Applicative
import qualified Data.Text as T
import qualified Data.Map.Strict as Map

class CmdMap c k v | c -> k, c -> v where
  lookup :: k -> c -> Maybe v

instance Eq a => CmdMap [(a,b)] a b where
  lookup = List.lookup

instance Ord a => CmdMap (Map.Map a b) a b where
  lookup = Map.lookup

-- This will eventually take a lookup map for the commands.
ast :: CmdMap c T.Text v => c -> Parser [LibellulaAST]
ast = cmd T.empty

term :: CmdMap c T.Text v => T.Text -> c -> Parser [LibellulaAST]
term pc mp = cmd pc mp <|> many numeral <|> many1 textToken

cmd :: CmdMap c T.Text v => T.Text -> c -> Parser [LibellulaAST]
cmd pc mp = do
  _ <- many space
  end <- atEnd
  case end of
    True -> fail "Cmd exhausted."
    False -> do
      key <- T.pack <$> many1 (satisfy (not . isSpace))
      let separator = if T.null pc then "" else " "
      let newCmd = pc <> separator <> key
      -- Perform a 2-level lookup: Try to match a single world (`key`)
      -- and if it does turn `pc` to be a standalone `TextToken`.
      -- If the lookup fails, go for the combined lookup of `newCmd`.
      singleLookup key <|> combinedLookup newCmd
  where
    singleLookup key = case lookup key mp of
     Nothing -> fail "singleLookup"
     Just _  -> do
       rst <- Command key <$> term T.empty mp
       return [TextToken pc, rst]
    combinedLookup newCmd = case lookup newCmd mp of
        Nothing -> cmd newCmd mp
        Just _  -> do
          rst <- Command newCmd <$> term T.empty mp
          return [rst]

numeral :: Parser LibellulaAST
numeral = nounNum <|> digitNum

nounNum :: Parser LibellulaAST
nounNum = do
  _ <- many space
  d <- many1 $ satisfy (not . isSpace)
  case T.toLower . T.pack $ d of
    "one" -> return $ Numeral 1
    "two" -> return $ Numeral 2
    "three" -> return $ Numeral 3
    "four" -> return $ Numeral 4
    "five" -> return $ Numeral 5
    "six" -> return $ Numeral 6
    "seven" -> return $ Numeral 7
    "eight" -> return $ Numeral 8
    "nine" -> return $ Numeral 9
    "ten" -> return $ Numeral 10
    "eleven" -> return $ Numeral 11
    "twelve" -> return $ Numeral 12
    _ -> fail $ d ++ " is not a numeral"

digitNum :: Parser LibellulaAST
digitNum = do
  _ <- many space
  d <- read <$> many1 digit
  return $ Numeral d

textToken :: Parser LibellulaAST
textToken = do
  _ <- many space
  TextToken . T.pack <$> manyTill anyChar endOfInput
