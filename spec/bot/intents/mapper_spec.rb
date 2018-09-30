require 'rails_helper'

RSpec.describe Intents::Mapper do
  describe '.map_intent_to_message' do
    it 'maps the :create_account intent to a message inviting the user to create an account, with quick replies' do
      intent = :create_account
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('create your account')
      expect(message[:message][:quick_replies]).to be_an_instance_of(Array)
      expect(message[:message][:quick_replies][0][:payload]).to eq('CREATE_ACCOUNT')
    end

    it 'maps the :CREATE_ACCOUNT intent to calling the create account service and returning an appropriate message' do
      intent = :CREATE_ACCOUNT
      expect(Users::RetrieveUserData).to receive(:call).with(1234) { 'user data' }
      expect(Users::FindOrCreateUser).to receive(:call).with(user_data: 'user data')
      message = Intents::Mapper.map_intent_to_message(intent, facebook_id: 1234)

      expect(message[:message][:text]).to include('successfully created an account')
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

    it 'maps a nil intent to a generic message' do
      intent = nil
      message = Intents::Mapper.map_intent_to_message(intent)

      expect(message[:message][:text]).to include('don\'t understand that')
    end
  end
end
