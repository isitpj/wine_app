class FacebookMessageBuilder
  class << self
    def build_message(to:, message:)
      built_message = {
        recipient: { id: to.facebook_id },
        message: { text: message.body }
      }

      built_message = add_quick_replies(message, built_message)
    end

    def build_quick_reply(content_type: 'text', title: nil, payload: nil)
      {
        content_type: content_type,
        title: title,
        payload: payload
      }
    end

    private

    def add_quick_replies(message, built_message)
      return built_message unless message.quick_replies
      built_message[:message][:quick_replies] = message.quick_replies if message.quick_replies
      
      built_message
    end
  end
end
