class FacebookMessageBuilder
  class << self
    def build_message(to:, message:)
      {
        recipient: { id: to.facebook_id },
        message: { text: message.body }
      }
    end

    def build_quick_reply(content_type: 'text', title: nil, payload: nil)
      {
        content_type: content_type,
        title: title,
        payload: payload
      }
    end
  end
end
