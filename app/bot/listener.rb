require 'facebook/messenger'
require 'net/http'
require 'uri'

include Facebook::Messenger

class Listener
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
  Bot.on :message do |message|
    RequestHandlers::Message.handle(message)
  end
end
