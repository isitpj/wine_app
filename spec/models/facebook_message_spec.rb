require 'rails_helper'

RSpec.describe FacebookMessage, type: :model do
  describe 'validations' do
    it 'must have a name' do
      message = build(:facebook_message, name: nil, body: 'Some text') # nil assignment overrides factory

      expect(message).to_not be_valid
    end

    it 'must have a category' do
      message = build(:facebook_message, category: nil, body: 'Some text') # nil assignment overrides factory

      expect(message).to_not be_valid
    end

    it 'must have a body' do
      message = build(:facebook_message)

      expect(message).to_not be_valid
    end
  end
end
