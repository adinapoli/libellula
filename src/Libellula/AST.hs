
module Libellula.AST where

import qualified Data.Text as T


data LibellulaAST =
    TextToken T.Text
  | Numeral Int
  deriving (Show, Eq)
