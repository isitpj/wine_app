module Classification
  class IntentClassifier
    def self.classify(text)
      map_text_to_intent(text)
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
    end
  end
end
