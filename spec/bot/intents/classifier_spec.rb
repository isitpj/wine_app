require 'rails_helper'

RSpec.describe Intents::Classifier do
  describe '.classify' do
    it 'correctly classifies a message asking to create an account' do
      text = 'I\'d like to create an account please'
      intent = Intents::Classifier.classify(text)

      expect(intent).to eq(:create_account)
    end

    it 'correctly classifies a message asking to add a new bottle of red wine' do
      text = 'I just had a bottle of red'
      intent = Intents::Classifier.classify(text)

      expect(intent).to eq(:add_red)
    end

    it 'correctly classifies a message asking to add a new bottle of white wine' do
      text = 'I just had a bottle of white'
      intent = Intents::Classifier.classify(text)

      expect(intent).to eq(:add_white)
    end
  end
end
