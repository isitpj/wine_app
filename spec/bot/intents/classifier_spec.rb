require 'rails_helper'

RSpec.describe Intents::Classifier do
  describe '.classify' do
    it 'correctly classifies a message asking to create an account' do
      text = 'I\'d like to create an account please'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:create_account)
    end

    it 'correctly classifies a message asking to add a new bottle of red wine' do
      text = 'I just had a bottle of red'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:add_red)
    end

    it 'correctly classifies a message asking to add a new bottle of white wine' do
      text = 'I just had a bottle of white'
      message = fake_incoming_message(text)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:add_white)
    end

    it 'correctly classifies an incoming quick_reply' do
      text = 'I just had a bottle of white'
      quick_reply_payload = 'just_anything_for_now'
      message = fake_incoming_message(text, quick_reply_payload)
      intent = Intents::Classifier.classify(message)

      expect(intent).to eq(:just_anything_for_now)
    end
  end
end
