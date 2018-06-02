require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["FB_ACCESS_TOKEN"])
Bot.on :message do |message|
  Bot.deliver({
      recipient: message.sender,
      message: {
        text: 'Hey there, Peter.'
      }
    }, access_token: ENV['FB_ACCESS_TOKEN'])
end
