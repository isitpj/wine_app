require 'rails_helper'

RSpec.describe FacebookMessageBuilder do
  let(:user) { create(:user)}

  describe '.build_message' do
    it 'builds a basic facebook message' do
      message = create(:facebook_message, body: 'Hello, world')
      built_message = FacebookMessageBuilder.build_message(to: user, message: message)

      expect(built_message).to have_key(:recipient)
      expect(built_message).to have_key(:message)

      expect(built_message[:recipient][:id]).to eq(user.facebook_id)
      expect(built_message[:message][:text]).to eq(message.body)
    end

    it 'builds a facebook message with quick replies' do
      message = create(:facebook_message,
        body: 'Hello, world',
        quick_replies: Array.wrap(
          FacebookMessageBuilder.build_quick_reply(
            title: 'A quick reply',
            payload: 'A_PAYLOAD'
            )
          )
        )

      built_message = FacebookMessageBuilder.build_message(to: user, message: message)

      expect(built_message[:message][:quick_replies]).to be_an_instance_of(Array)
      expect(built_message[:message][:quick_replies][0]['content_type']).to eq 'text'
      expect(built_message[:message][:quick_replies][0]['title']).to eq 'A quick reply'
      expect(built_message[:message][:quick_replies][0]['payload']).to eq 'A_PAYLOAD'
    end
  end

  describe '.build_quick_reply' do
    it 'builds a quick_reply, with a default content_type of text' do
      title = 'Tap to send quick reply!'
      payload = 'A PAYLOAD'

      quick_reply = FacebookMessageBuilder.build_quick_reply(
        title: title,
        payload: payload,
      )

      expect(quick_reply[:content_type]).to eq('text')
      expect(quick_reply[:title]).to eq(title)
      expect(quick_reply[:payload]).to eq(payload)
    end

    it 'builds a quick_reply, with an overridden content_type' do
      quick_reply = FacebookMessageBuilder.build_quick_reply(
        content_type: 'location',
      )

      expect(quick_reply[:content_type]).to eq('location')
      expect(quick_reply[:title]).to eq(nil)
      expect(quick_reply[:payload]).to eq(nil)
    end
  end
end
