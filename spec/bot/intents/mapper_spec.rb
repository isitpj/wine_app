require 'rails_helper'

RSpec.describe Intents::Mapper do
  describe '.map_intent_to_message' do
    it 'maps the :create_account intent to a message inviting the user to create an account' do
      intent = :create_account
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('create your account')
      expect(message[:message][:quick_replies]).to be_an_instance_of(Array)
      expect(message[:message][:quick_replies][0][:payload]).to eq('CREATE_ACCOUNT')
    end

    it 'maps the :add_red intent to a message inviting the user to add a bottle of red' do
      intent = :add_red
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('add a new bottle of red')
    end

    it 'maps the :add_white intent to a message inviting the user to add a bottle of white' do
      intent = :add_white
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('add a new bottle of white')
    end

    it 'maps a nil intent to a geeric message' do
      intent = nil
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('don\'t understand that')
    end
  end
end
