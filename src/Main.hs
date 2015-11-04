--
-- Copyright (c) 2015 Fernando Freire - https://github.com/dogonthehorizon
-- MIT license (see https://opensource.org/licenses/MIT)
--

import System.Console.ArgParser

data AConsoleArgs =
    AConsoleArgs String String String
    deriving (Show)

aConsoleArgsParser :: ParserSpec AConsoleArgs
aConsoleArgsParser = AConsoleArgs
    `parsedBy` reqPos "account-id" `Descr` "account id that you wish to access"
    `andBy`    reqPos "aws-role"   `Descr` "role that you wish to assume upon login"
    `andBy`    optPos "default" "browser" `Descr` "desired browser to open the AWS console in"

main = do
    interface <- mkApp aConsoleArgsParser
    runApp interface print
