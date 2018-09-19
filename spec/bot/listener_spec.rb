require 'rails_helper'

RSpec.describe Listener do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text, :messaging)

  describe 'Bot#on(message)' do
    it 'passes the message to RequestHandlers::Message.handle' do
      message = fake_message('Hello, world')
      expect(RequestHandlers::Message).to receive(:handle).with(message)

      Bot.trigger(:message, message)
    end
  end

  private

  def fake_message(message_text, quick_reply_payload = nil)
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    messaging = {
      "sender"=>sender,
        "recipient"=>recipient,
        "timestamp"=>timestamp,
        "message"=>{
          "mid"=> "0j3SQeNnpIDLxBwJl7hRofACd_36bJGN3qXKXv32Bok8GqJfA284e1hsnOagFiVZsbqLLainVGIVURWOlNJ4Tw",
          "seq"=>2171281,
          "text"=>message_text
        }
      }
      messaging['message']['quick_reply'] = {"payload"=>quick_reply_payload} if quick_reply_payload
    FakeMessage.new(sender, recipient, timestamp, message_text, messaging)
  end
end
