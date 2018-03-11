{-# LANGUAGE OverloadedStrings #-}

module Slack.Conversations where

import Network.HTTP.Simple
import Network.HTTP.Conduit
import Data.Aeson


data MessagePayload = MessagePayload {  mesageType :: String, userId :: String, text :: String, ts :: Float } deriving Show

instance FromJSON MessagePayload where
    parseJSON (Object v) = MessagePayload <$> (v .: "type")
                                          <*> (v .: "user")
                                          <*> (v .: "text")
                                          <*> (conv <$> (v .: "ts"))
      where conv = read :: String -> Float
    parseJSON _          = mempty

data SlackPayload = SlackPayload { ok :: Bool, messages :: [MessagePayload] } deriving Show

instance FromJSON SlackPayload where
    parseJSON (Object v) = SlackPayload <$> (v .: "ok")
                                        <*> (v .: "messages")
    parseJSON _          = mempty


history token channel = do
  request <- parseUrlThrow $ concat ["https://slack.com/api/conversations.history?token=", token, "&channel=", channel, "&pretty=1"]
  res <- httpLBS request
  let json = decode (getResponseBody res) :: Maybe SlackPayload
  case json of
    Just json -> return json
