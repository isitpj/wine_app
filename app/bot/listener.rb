require 'facebook/messenger'
require 'net/http'
require 'uri'

include Facebook::Messenger

class Listener
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["FB_ACCESS_TOKEN"])
  Bot.on :message do |message|
    sender = message.sender
    uri = URI.parse("https://graph.facebook.com/#{sender['id']}?fields=first_name,last_name,profile_pic&access_token=#{ENV["FB_ACCESS_TOKEN"]}")
    ap uri
    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)

    first_name = json_response['first_name']
    last_name = json_response['last_name']
    /(?<wine_colour>red|white)/i =~ message.text

    response = if wine_colour
      "How lovely! Would you like to add a new bottle of #{wine_colour.downcase} to your cellar?"
    else
      "Hey there, #{first_name} #{last_name}."
    end

    Bot.deliver({
      recipient: sender,
      message: {
        text: response
      }
    }, access_token: ENV['FB_ACCESS_TOKEN'])
  end
end
