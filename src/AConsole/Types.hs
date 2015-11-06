--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

module AConsole.Types
    (
      AccountId,
      accountId,
      AWSRole,
      ARN
    ) where

import Data.Char (isDigit)

-- | Describes a valid account id according to AWS.
--
-- TODO: Hide this type behind a module so that accountId is the only
--       exposed constructor
data AccountId = AccountId String

instance Show AccountId where
    show (AccountId a) = a

-- | Constructor for a valid account id that is twelve digits long
-- http://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html
accountId :: String -> AccountId
accountId a | length a == 12 && all isDigit a = AccountId a
            | otherwise = error "Invalid account id. Must be a string of 9 digits."

type AWSRole = String
type ARN = String
