--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

module AConsole.Predicates
    (
      isRoleChar
    ) where

import Data.Char

-- | Predicate returning True if the given character is allowed in AWS
-- role names.
--
-- TODO: Its possible that some unwanted chars can be validated against
--       these categories. Write some tests to ensure this doesn't happen.
isRoleChar c = case generalCategory c of
    UppercaseLetter         -> True  -- A-Z
    LowercaseLetter         -> True  -- a-z
    DecimalNumber           -> True  -- 0-9
    DashPunctuation         -> True  -- -
    ConnectorPunctuation    -> True  -- _
    OtherPunctuation        -> True  -- @, ., ,
    MathSymbol              -> True  -- +, =
    _                       -> False -- Reject everything else
