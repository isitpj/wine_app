class FacebookMessageBuilder
  class << self
    def build_message(to:, message:)
      {
        recipient: { id: to.facebook_id },
        message: { text: message.body }
      }
    end
  end
end
