require 'rails_helper'

RSpec.describe RequestHandlers::Message do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text, :messaging)

  before(:each) do
    stub_facebook_user_data_request
  end

  describe '.handle' do
    it 'responds with a message' do
      stub_deliver
      message = fake_incoming_message('Hello, world')
      expect(Intents::Classifier).to receive(:classify)
      expect(Intents::Mapper).to receive(:map_intent_to_message) { fake_outgoing_message('Hello, world') }

      RequestHandlers::Message.handle(message)
    end

    it 'calls the IntentClassifier class with a free-form message' do
      stub_deliver
      message = fake_incoming_message('Hello, world')
      expect(Intents::Classifier).to receive(:classify).with(message)

      RequestHandlers::Message.handle(message)
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

  def fake_incoming_message(message_text, quick_reply_payload = nil)
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    messaging = {
      "sender"=>{"id"=>"1732016540208841"},
        "recipient"=>{"id"=>"364376550736984"},
        "timestamp"=>1535288528163,
        "message"=>{
          "quick_reply"=>{"payload"=>quick_reply_payload},
          "mid"=> "0j3SQeNnpIDLxBwJl7hRofACd_36bJGN3qXKXv32Bok8GqJfA284e1hsnOagFiVZsbqLLainVGIVURWOlNJ4Tw",
          "seq"=>2171281,
          "text"=>"Account"
        }
      }
    FakeMessage.new(sender, recipient, timestamp, message_text, messaging)
  end

  def fake_outgoing_message(text, quick_replies = nil)
    {
      message: {
        text: text,
        quick_replies: quick_replies
      }
    }
  end

  def expect_bot_message_to_have_text(message, text)
    expect(Bot).to receive(:deliver)
      .with(
        hash_including(message: hash_including(text: text)),
        access_token: ENV['FB_ACCESS_TOKEN']
      )
  end

  def expect_bot_message_to_have_quick_reply(message, quick_reply)
    expect(Bot).to receive(:deliver)
      .with(
        hash_including(
          message: hash_including(
            quick_replies: array_including(quick_reply)
          )
        ),
        access_token: ENV['FB_ACCESS_TOKEN']
      )

      RequestHandlers::Message.handle(message)
  end

  def expect_bot_message_not_to_have_quick_replies(message)
    expect(Bot).to receive(:deliver)
      .with(
        hash_including(
          message: hash_excluding(
            quick_replies: instance_of(Array)
          )
        ),
        access_token: ENV['FB_ACCESS_TOKEN']
      )

      RequestHandlers::Message.handle(message)
  end

  def stub_facebook_user_data_request
    stub_request(:get, facebook_user_data_request_url)
      .with(facebook_user_data_request_headers)
      .to_return(facebook_user_data_response)
  end

  def facebook_user_data_request_url
    "https://graph.facebook.com/1234?fields=first_name,last_name,profile_pic&access_token=#{ENV['FB_ACCESS_TOKEN']}"
  end

  def facebook_user_data_request_headers
    {headers: {'Accept'=>'*/*'}}
  end

  def facebook_user_data_response
    {
      status: 200,
      body: {
        "first_name" => "Peter",
        "last_name" => "Johnstone",
        "profile_pic" => "https://platform-lookaside.fbsbx.com/platform/profilepic/",
        "id" => "1234"
      }.to_json,
      headers: {}
    }
  end

  def stub_deliver
    expect(Bot).to receive(:deliver)
  end
end
