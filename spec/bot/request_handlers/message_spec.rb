require 'rails_helper'

RSpec.describe Message do
  describe '.handle' do
    it 'responds with a message' do
      expect_bot_message_to_have_text('It\'s Han, but that\'s okay')
      message = fake_incoming_message('Hello, world')
      expect(Intents::Classifier).to receive(:classify)
      expect(Intents::Mapper).to receive(:map_intent_to_message) { fake_outgoing_message('It\'s Han, but that\'s okay') }

      Message.handle(message)
    end

    it 'calls the IntentClassifier class with a free-form message' do
      stub_deliver
      message = fake_incoming_message('Hello, world')
      expect(Intents::Classifier).to receive(:classify).with(message)

      Message.handle(message)
    end

    it 'calls the IntentClassifier class with a quick-reply message' do
      stub_deliver
      text = 'any old message text'
      quick_reply_payload = 'any_quick_reply_payload'
      message = fake_incoming_message(text, quick_reply_payload)

      expect(Intents::Classifier).to receive(:classify).with(message)

      Bot.trigger(:message, message)
    end
  end

  private

  def fake_outgoing_message(text, quick_replies = nil)
    {
      message: {
        text: text,
        quick_replies: quick_replies
      }
    }
  end

  def expect_bot_message_to_have_text(text)
    expect(Bot).to receive(:deliver)
      .with(
        hash_including(message: hash_including(text: text)),
        access_token: ENV['ACCESS_TOKEN']
      )
  end

  def stub_deliver
    expect(Bot).to receive(:deliver)
  end
end
