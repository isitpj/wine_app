module RequestHandlers
  class Message
    def self.handle(message)
      sender = message.sender
      user_data = Users::RetrieveUserData.call(sender['id'])
      intent = Intents::Classifier.classify(message.text)

      response_message = Intents::Mapper.map_intent_to_message(intent)
      response_message[:recipient] = sender

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
