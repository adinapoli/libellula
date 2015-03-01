{-# LANGUAGE OverloadedStrings #-}
module Libellula.Parser where

import Data.Char
import Data.Attoparsec.Text
import Libellula.AST
import Control.Applicative
import qualified Data.Text as T


numeral :: Parser LibellulaAST
numeral = nounNum <|> digitNum

nounNum :: Parser LibellulaAST
nounNum = do
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
    "evelen" -> return $ Numeral 11
    "twelve" -> return $ Numeral 12
    _ -> fail $ d ++ " is not a numeral"

digitNum :: Parser LibellulaAST
digitNum = do
  d <- read <$> many1 digit
  return $ Numeral d
