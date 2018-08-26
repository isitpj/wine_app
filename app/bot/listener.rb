require 'facebook/messenger'
require 'net/http'
require 'uri'

include Facebook::Messenger

class Listener
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["FB_ACCESS_TOKEN"])
  Bot.on :message do |message|
    sender = message.sender
    uri = URI.parse("https://graph.facebook.com/#{sender['id']}?fields=first_name,last_name,profile_pic&access_token=#{ENV["FB_ACCESS_TOKEN"]}")

    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)

    first_name = json_response['first_name']
    last_name = json_response['last_name']
    profile_pic_url = json_response['profile_pic']
    /(?<account_creation_request>account|sign up|signup)/i =~ message.text
    /(?<wine_colour>red|white)/i =~ message.text

    response = if wine_colour
      "How lovely! Would you like to add a new bottle of #{wine_colour.downcase} to your cellar?"
    elsif account_creation_request
      'Would you like to create your account with Charles d\'Née?'
    else
      "Hey there, #{first_name} #{last_name}."
    end

    response_message = {
      recipient: sender,
      message: {
        text: response
      }
    }

    account_creation_quick_replies = [
      {
        content_type: 'text',
        title: 'Yes please!',
        payload: 'CREATE_ACCOUNT'
      },
      {
        content_type: 'text',
        title: 'Not right now',
        payload: 'NULL'
      }
    ]

    response_message[:message][:quick_replies] = account_creation_quick_replies if account_creation_request

    if message.messaging['message']['quick_reply']
      payload = message.messaging['message']['quick_reply']['payload']
      if payload == 'CREATE_ACCOUNT'
        response_message[:message][:text] = 'Great! You have successfully opened an account with Charles d\'Née.'
        User.find_or_create_by(facebook_id: sender['id']) do |user|
          user.first_name = first_name
          user.last_name = last_name
          profile_pic_url = profile_pic_url
        end
      end
    end

    Bot.deliver(response_message, access_token: ENV['FB_ACCESS_TOKEN'])
  end
end
