require 'rails_helper'

RSpec.describe Intents::Classifier do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text, :messaging)
  describe '.classify' do
    it 'correctly classifies a message asking to create an account' do
      text = 'I\'d like to create an account please'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:create_account)
    end

    it 'correctly classifies a message asking to add a new bottle of red wine' do
      text = 'I just had a bottle of red'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:add_red)
    end

    it 'correctly classifies a message asking to add a new bottle of white wine' do
      text = 'I just had a bottle of white'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:add_white)
    end

    it 'correctly classifies an incoming quick_reply' do
      text = 'I just had a bottle of white'
      quick_reply_payload = 'just_anything_for_now'
      message = fake_incoming_message(text, quick_reply_payload)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:just_anything_for_now)
    end
  end

  private

  def fake_incoming_message(message_text, quick_reply_payload = nil)
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    messaging = {
      "sender"=>{"id"=>"1732016540208841"},
        "recipient"=>{"id"=>"364376550736984"},
        "timestamp"=>1535288528163,
        "message"=>{
          "mid"=> "0j3SQeNnpIDLxBwJl7hRofACd_36bJGN3qXKXv32Bok8GqJfA284e1hsnOagFiVZsbqLLainVGIVURWOlNJ4Tw",
          "seq"=>2171281,
          "text"=>"Account"
        }
      }
    messaging['message']['quick_reply'] = {'payload' => quick_reply_payload} if quick_reply_payload
    FakeMessage.new(sender, recipient, timestamp, message_text, messaging)
  end
end
