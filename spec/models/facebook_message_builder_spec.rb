require 'rails_helper'

RSpec.describe FacebookMessageBuilder do
  describe '.build_message' do
    it 'builds a basic facebook message' do
      user = create(:user)
      text = 'Hello, world'
      message = FacebookMessageBuilder.build_message(to: user, text: text)

      expect(message).to have_key(:recipient)
      expect(message).to have_key(:message)

      expect(message[:recipient][:id]).to eq(user.facebook_id)
      expect(message[:message][:text]).to eq(text)
    end
  end
end
