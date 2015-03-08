
module Libellula.AST where

import qualified Data.Text as T

type Keyword = T.Text

data LibellulaAST =
    TextToken T.Text
  | Numeral Int
  | Command Keyword [LibellulaAST]
  deriving (Show, Eq)
