require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Listener do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text, :quick_replies)

  before(:each) do
    stub_facebook_user_data_request
  end

  describe 'Bot#on(message)' do
    it 'responds with a message' do
      expect(Bot).to receive(:deliver)
      message = fake_message('Hello, world')
      Bot.trigger(:message, message)
    end

    it 'invites the user to add a new bottle of red wine' do
      user_message = fake_message('I just had a bottle of red')
      expected_response = 'How lovely! Would you like to add a new bottle of red to your cellar?'

      expect_bot_message_to_have_text(user_message, expected_response)
    end

    it 'invites the user to add a new bottle of white wine' do
      user_message = fake_message('I just had a bottle of white')
      expected_response = 'How lovely! Would you like to add a new bottle of white to your cellar?'

      expect_bot_message_to_have_text(user_message, expected_response)
    end

    it 'makes a GET request to facebook to retrieve profile information' do
      user_message = fake_message('Hey bot')

      allow(Bot).to receive(:deliver) {}
      expect(URI).to receive(:parse).with(facebook_user_data_request_url)
      expect(Net::HTTP).to receive(:get) { "{\"first_name\":\"Peter\",\"last_name\":\"Johnstone\"}" }

      Bot.trigger(:message, user_message)
    end

    it 'invites a user to sign up after they ask to with quick replies for yes' do
      message = 'I\'d like to create an account please'
      quick_reply = {
        content_type: 'text',
        title: 'Yes please!',
        payload: 'CREATE_ACCOUNT'
      }
      user_message = fake_message(message, quick_replies: quick_reply)

      expected_response = 'Would you like to create your account with Charles d\'Née?'

      expect_bot_message_to_have_text(user_message, expected_response)
      expect_bot_message_to_have_quick_reply(user_message, quick_reply)
    end
  end

  private

  def fake_message(message_text, quick_replies: [])
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    quick_replies = quick_replies
    FakeMessage.new(sender, recipient, timestamp, message_text, quick_replies)
  end

  def expect_bot_message_to_have_text(message, text)
    expect(Bot).to receive(:deliver)
      .with(
        hash_including(message: hash_including(text: text)),
        access_token: ENV['FB_ACCESS_TOKEN']
      )

      Bot.trigger(:message, message)
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

      Bot.trigger(:message, message)
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
end
