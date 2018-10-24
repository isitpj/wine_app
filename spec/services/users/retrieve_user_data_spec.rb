require 'rails_helper'

RSpec.describe Users::RetrieveUserData do
  describe '#call' do
    it 'makes a GET request to retrieve a user\'s data' do
      expect(URI).to receive(:parse).with(facebook_user_data_request_url)
      expect(Net::HTTP).to receive(:get) { facebook_user_data_response }

      Users::RetrieveUserData.call(fake_user_facebook_id)
    end

    it 'parses the returned JSON object and returns a hash' do
      expect(JSON).to receive(:parse)
      allow_any_instance_of(Users::RetrieveUserData).to receive(:get_facebook_data) { facebook_user_data_response }

      data = Users::RetrieveUserData.call(fake_user_facebook_id)
    end
  end

  private

  def facebook_user_data_request_url
    "https://graph.facebook.com/#{fake_user_facebook_id}?fields=first_name,last_name,profile_pic&access_token=#{ENV['ACCESS_TOKEN']}"
  end

  def fake_user_facebook_id
    1234
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
    }.to_json
  end
end
