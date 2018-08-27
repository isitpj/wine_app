require 'rails_helper'

RSpec.describe Users::RetrieveUserData do
  describe '#call' do
    it 'makes a GET request to retrieve a user\'s data' do
      expect(URI).to receive(:parse).with(facebook_user_data_request_url)
      expect(Net::HTTP).to receive(:get)

      Users::RetrieveUserData.call(fake_user_facebook_id)
    end
  end

  private

  def facebook_user_data_request_url
    "https://graph.facebook.com/#{fake_user_facebook_id}?fields=first_name,last_name,profile_pic&access_token=#{ENV['FB_ACCESS_TOKEN']}"
  end

  def fake_user_facebook_id
    1234
  end
end
