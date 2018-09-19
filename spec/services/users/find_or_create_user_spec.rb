require 'rails_helper'

RSpec.describe Users::FindOrCreateUser do
  describe '#call' do
    it 'creates a new user' do
      expect{Users::FindOrCreateUser.call(user_data: user_data)}.to change{User.count}.from(0).to(1)
    end
  end

  private

  def user_data
    {
      "first_name" => "Peter",
      "last_name" => "Johnstone",
      "profile_pic" => "https://platform-lookaside.fbsbx.com/platform/profilepic/",
      "id" => "1234"
    }
  end
end
