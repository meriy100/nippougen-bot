module Nippoubot where

import Web.Slack
import Web.Slack.Message
import System.Environment (lookupEnv)
import Data.Maybe (fromMaybe)
import Data.Maybe (fromJust)


import qualified Data.Text as T

import Slack.Conversations

apiToken = do
  apiToken <- fromMaybe (error "SLACK_API_TOKEN not set")
    <$> lookupEnv "SLACK_API_TOKEN"
  return apiToken

-- searchOperate ts =

nipppouBot :: SlackBot ()
nipppouBot (Message cid _ msg _ _ _)
  | msg' `elem` ["nipppou-bot -h", "nipppoubot --help"]
  = send (show cid)
  | msg' `elem` ["report hi"]
  = send "今日の作業内容"
  | otherwise
  = send $ show $  history "" (show cid)

  -- =  send "明日の作業予定"
  where
      msg'  = T.unpack msg
      send  = sendMessage cid . T.pack -- そのまま送る
nipppouBot _ = return ()
