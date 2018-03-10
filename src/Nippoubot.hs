module Nippoubot where

import Web.Slack
import Web.Slack.Message
import qualified Data.Text as T

nipppouBot :: SlackBot ()
nipppouBot (Message cid _ msg _ _ _)
  | msg' `elem` ["nipppou-bot -h", "nipppoubot --help"]
  = send (show cid)
  | msg' `elem` ["report hi"]
  = send "今日の作業内容"
  | otherwise
  = send "明日の作業予定"
  where
      msg'  = T.unpack msg
      send  = sendMessage cid . T.pack -- そのまま送る
nipppouBot _ = return ()
