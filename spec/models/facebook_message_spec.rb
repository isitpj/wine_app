require 'rails_helper'

RSpec.describe FacebookMessage, type: :model do
  describe 'basics' do
    it 'must have a name' do
      message = create(:facebook_message)

      ap message
    end
  end
end
