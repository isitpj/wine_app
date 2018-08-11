require 'facebook/messenger'

include Facebook::Messenger

class Listener
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["FB_ACCESS_TOKEN"])
  Bot.on :message do |message|
    sender = message.sender
    /(?<wine_colour>red|white)/i =~ message.text
    response = if wine_colour
      "How lovely! Would you like to add a new bottle of #{wine_colour.downcase} to your cellar?"
    else
      "Hey there, #{sender}."
    end
    Bot.deliver({
      recipient: sender,
      message: {
        text: response
      }
    }, access_token: ENV['FB_ACCESS_TOKEN'])
  end
end
