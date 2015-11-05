--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

import System.Console.ArgParser
import Text.Format (format)
import Data.Char (isDigit)

-- TODO: Hide this type behind a module so that accountId is the only
--       exposed constructor
data AccountId = AccountId String

instance Show AccountId where
    show (AccountId a) = a

-- Constructor for a valid account id that is twelve digits long
-- http://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html
accountId :: String -> AccountId
accountId a | length a == 12 && all isDigit a = AccountId a
            | otherwise = error "Invalid account id. Must be a string of 9 digits."

type AWSRole = String
type ARN = String

-- Custom datatype describing the expected type and number of arguments
data AConsoleArgs =
    AConsoleArgs String String String
    deriving (Show)

-- Options parser using AConsoleArgs
aConsoleArgsParser :: ParserSpec AConsoleArgs
aConsoleArgsParser = AConsoleArgs
    `parsedBy` reqPos "account-id" `Descr` "account id that you wish to access"
    `andBy`    reqPos "aws-role"   `Descr` "role that you wish to assume upon login"
    `andBy`    optPos "default" "browser" `Descr` "desired browser to open the AWS console in"

-- Given an accountId and awsRole, return a properly formatted ARN
generateIdentityARN :: AccountId -> AWSRole -> ARN
generateIdentityARN accountId awsRole =
    format "arn:aws:iam::{0}:role/{1}" [show accountId, awsRole]

printARN :: AConsoleArgs -> IO ()
printARN (AConsoleArgs acct role _) =
    print $ generateIdentityARN (accountId acct) role

main = do
    interface <- mkApp aConsoleArgsParser
    runApp interface printARN
