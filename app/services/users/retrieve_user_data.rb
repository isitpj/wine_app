module Users
  class RetrieveUserData < ApplicationService
    attr_reader :facebook_id
    FACEBOOK_ENDPOINT = 'https://graph.facebook.com/'

    def initialize(facebook_id)
      @facebook_id = facebook_id
    end

    def call
      data = get_facebook_data
      JSON.parse(data)
    end

    private

    def get_facebook_data
      Net::HTTP.get(uri)
    end

    def uri
      URI.parse(FACEBOOK_ENDPOINT + facebook_id.to_s + fields + access_token)
    end

    def fields
      '?fields=first_name,last_name,profile_pic'
    end

    def access_token
      "&access_token=#{ENV["FB_ACCESS_TOKEN"]}"
    end
  end
end
