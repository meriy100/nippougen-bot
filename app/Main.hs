module Main where

import Web.Slack
import System.Environment (lookupEnv)
import Data.Maybe (fromMaybe)
import Control.Applicative

import Nippoubot (nipppouBot)

myConfig :: String -> SlackConfig
myConfig apiToken = SlackConfig
         { _slackApiToken = apiToken -- Specify your API token here
         }


main :: IO ()
main = do
  apiToken <- fromMaybe (error "SLACK_API_TOKEN not set")
               <$> lookupEnv "SLACK_API_TOKEN"
  runBot (myConfig apiToken) nipppouBot ()
