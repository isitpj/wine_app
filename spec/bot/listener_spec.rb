require 'rails_helper'

RSpec.describe Listener do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text)

  describe 'Bot#on(message)' do
    it 'responds with a message' do
      expect(Bot).to receive(:deliver)
      message = fake_message('Hello, world')
      Bot.trigger(:message, message)
    end

    it 'invites the user to add a new bottle of red wine' do
      user_message = fake_message('I just had a bottle of red')
      expected_response = 'How lovely! Would you like to add a new bottle of red to your cellar?'
      expect_bot_message_to_contain(user_message, expected_response)

      Bot.trigger(:message, user_message)
    end
  end

  private

  def fake_message(message_text)
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    FakeMessage.new(sender, recipient, timestamp, message_text)
  end

  def expect_bot_message_to_contain(message, text)
    expect(Bot).to receive(:deliver).with({
      recipient: message.sender,
      message: {
        text: text
      }
      }, access_token: ENV['FB_ACCESS_TOKEN'])
  end
end
