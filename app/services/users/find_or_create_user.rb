module Users
  class FindOrCreateUser < ApplicationService
    attr_reader :user_data

    def initialize(user_data:)
      @user_data = user_data
    end

    def call
      User.find_or_create_by(facebook_id: user_data['id']) do |user|
        user.first_name = user_data['first_name']
        user.last_name = user_data['last_name']
        user.facebook_id = user_data['id']
        user.profile_pic_url = user_data['profile_pic_url']
      end
    end
  end
end
