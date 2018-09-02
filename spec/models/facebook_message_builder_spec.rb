require 'rails_helper'

RSpec.describe FacebookMessageBuilder do
  describe '.build_message' do
    it 'builds a basic facebook message' do
      user = create(:user)
      message = create(:facebook_message, body: 'Hello, world')
      built_message = FacebookMessageBuilder.build_message(to: user, message: message)

      expect(built_message).to have_key(:recipient)
      expect(built_message).to have_key(:message)

      expect(built_message[:recipient][:id]).to eq(user.facebook_id)
      expect(built_message[:message][:text]).to eq(message.body)
    end
  end
end
