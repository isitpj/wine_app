module RequestHandlers
  class Message
    def self.handle(message)
      sender = message.sender
      user_data = Users::RetrieveUserData.call(sender['id'])
      intent = Intents::Classifier.classify(message.text)

      first_name = user_data['first_name']
      last_name = user_data['last_name']

      response = case intent
      when :create_account
        'Would you like to create your account with Charles d\'Née?'
      when :add_red
        "How lovely! Would you like to add a new bottle of red to your cellar?"
      when :add_white
        "How lovely! Would you like to add a new bottle of white to your cellar?"
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

      response_message[:message][:quick_replies] = account_creation_quick_replies if intent == :create_account

      if message.messaging['message']['quick_reply']
        payload = message.messaging['message']['quick_reply']['payload']
        if payload == 'CREATE_ACCOUNT'
          response_message[:message][:text] = 'Great! You have successfully created an account with Charles d\'Née.'
          ::Users::FindOrCreateUser.call(user_data: user_data)
        end
      end

      Bot.deliver(response_message, access_token: ENV['FB_ACCESS_TOKEN'])
    end
  end
end
