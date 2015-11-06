--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

import System.Console.ArgParser
import Text.Format (format)
import AConsole.Types

data AConsoleArgs =
    AConsoleArgs String String String
    deriving (Show)

-- | Describes the valid options for this command.
aConsoleArgsParser :: ParserSpec AConsoleArgs
aConsoleArgsParser = AConsoleArgs
    `parsedBy` reqPos "account-id" `Descr` "account id that you wish to access"
    `andBy`    reqPos "aws-role"   `Descr` "role that you wish to assume upon login"
    `andBy`    optPos "default" "browser" `Descr` "desired browser to open the AWS console in"

-- | Generate a properly formatted IAM ARN given an account id and role.
generateIdentityARN :: AccountId -> AWSRole -> ARN
generateIdentityARN accountId awsRole =
    format "arn:aws:iam::{0}:role/{1}" [show accountId, awsRole]

-- | Prints a properly formatted IAM ARN
printARN :: AConsoleArgs -> IO ()
printARN (AConsoleArgs acct role _) =
    print $ generateIdentityARN (accountId acct) role

main = do
    interface <- mkApp aConsoleArgsParser
    runApp interface printARN
