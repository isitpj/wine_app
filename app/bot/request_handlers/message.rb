module RequestHandlers
  class Message
    def self.handle(message)
      intent = Intents::Classifier.classify(message)
      response_message = Intents::Mapper.map_intent_to_message(intent)
      response_message[:recipient] = message.sender

      Bot.deliver(response_message, access_token: ENV['FB_ACCESS_TOKEN'])
    end
  end
end
