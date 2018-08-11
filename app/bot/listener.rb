require 'facebook/messenger'

include Facebook::Messenger

class Listener
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["FB_ACCESS_TOKEN"])
  Bot.on :message do |message|
    sender = message.sender
    if /red/i.match? message.text
      Bot.deliver({
        recipient: sender,
        message: {
          text: 'How lovely! Would you like to add a new bottle of red to your cellar?'
        }
        }, access_token: ENV['FB_ACCESS_TOKEN'])
    elsif /white/i.match? message.text
      Bot.deliver({
        recipient: sender,
        message: {
          text: 'How lovely! Would you like to add a new bottle of white to your cellar?'
        }
        }, access_token: ENV['FB_ACCESS_TOKEN'])
    else
      Bot.deliver({
        recipient: sender,
        message: {
          text: "Hey there, #{sender}."
        }
        }, access_token: ENV['FB_ACCESS_TOKEN'])
    end
  end
end
