class FacebookMessageBuilder
  class << self
    def build_message(to:, text:)
      {
        recipient: { id: to.facebook_id },
        message: { text: text }
      }
    end
  end
end
