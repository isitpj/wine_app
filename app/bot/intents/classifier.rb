module Intents
  class Classifier
    def self.classify(message)
      return quick_reply(message)['payload'].to_sym if quick_reply(message)
      map_text_to_intent(message.text)
    end

    private

    class << self
      private def map_text_to_intent(text)
        if /(account|sign up|signup)/i.match?(text)
          :create_account
        elsif /red/i.match?(text)
          :add_red
        elsif /white/i.match?(text)
          :add_white
        end
      end

      private def quick_reply(message)
        message.messaging['message']['quick_reply']
      end
    end
  end
end
