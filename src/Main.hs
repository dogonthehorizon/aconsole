--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

{-# LANGUAGE OverloadedStrings #-}

import System.Console.ArgParser
import Text.Format

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
generateARN :: String -> String -> String
generateARN accountId awsRole =
    format "arn:aws:iam::{0}:role/{1}" [accountId, awsRole]

main = do
    interface <- mkApp aConsoleArgsParser
    runApp interface print
