require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Listener do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :text)

  before(:each) do
    response_data = {
      "first_name" => "Peter",
      "last_name" => "Johnstone",
      "profile_pic" => "https://platform-lookaside.fbsbx.com/platform/profilepic/",
      "id" => "123456"
    }.to_json

    stub_request(:get, "https://graph.facebook.com/1234?access_token=#{ENV['FB_ACCESS_TOKEN']}&fields=first_name,last_name,profile_pic").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'graph.facebook.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: response_data, headers: {})
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
      expect_bot_message_to_contain(user_message, expected_response)

      Bot.trigger(:message, user_message)
    end

    it 'invites the user to add a new bottle of white wine' do
      user_message = fake_message('I just had a bottle of white')
      expected_response = 'How lovely! Would you like to add a new bottle of white to your cellar?'
      expect_bot_message_to_contain(user_message, expected_response)

      Bot.trigger(:message, user_message)
    end

    it 'makes a GET request to facebook to retrieve profile information' do
      user_message = fake_message('Hey bot')
      string = "https://graph.facebook.com/#{user_message.sender['id']}?fields=first_name,last_name,profile_pic&access_token=#{ENV["FB_ACCESS_TOKEN"]}"

      allow(Bot).to receive(:deliver) {}
      expect(URI).to receive(:parse)
      expect(Net::HTTP).to receive(:get) { "{\"first_name\":\"Peter\",\"last_name\":\"Johnstone\"}" }

      Bot.trigger(:message, user_message)
    end

    it 'invites a user to sign up after they ask to' do
      user_message = fake_message('I\'d like to create an account please')
      expected_response = 'Would you like to create your account with Charles d\'Née?'

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
