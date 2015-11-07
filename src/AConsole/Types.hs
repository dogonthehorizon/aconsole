--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

module AConsole.Types
    (
      AccountId,
      accountId,
      AWSRole,
      awsRole,
      ARN
    ) where

import Data.Char

-- | Describes a valid account id according to AWS.
data AccountId = AccountId String

-- | An AccountId is just a string with constraints, lets show it like
-- a string.
instance Show AccountId where
    show (AccountId a) = a

-- | Constructor for a valid account id that is twelve digits long
-- http://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html
accountId :: String -> AccountId
accountId a | length a == 12 && all isDigit a = AccountId a
            | otherwise = error "Invalid account id. Must be a string of 9 digits."

-- | Describes a valid AWS Role according to AWS.
data AWSRole = AWSRole String

-- | An AWSRole is just a string with constraints, lets show it like
-- a string.
instance Show AWSRole where
    show (AWSRole a) = a

-- | Predicate returning True if the given character is allowed in AWS
-- role names.
--
-- TODO: Its possible that some unwanted chars can be validated against
--       these categories. Write some tests to ensure this doesn't happen.
isRoleChar c = case generalCategory c of
    UppercaseLetter         -> True  -- A-Z
    LowercaseLetter         -> True  -- a-z
    DashPunctuation         -> True  -- -
    ConnectorPunctuation    -> True  -- _
    OtherPunctuation        -> True  -- @, ., ,
    MathSymbol              -> True  -- +, =
    _                       -> False -- Reject everything else

-- | Constructor for a valid AWS role given the following constraints.
-- http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html
awsRole :: String -> AWSRole
awsRole a | all isRoleChar a = AWSRole a
          | otherwise = error "Invalid AWS role name."

type ARN = String
