require 'rails_helper'
require 'spec_helper'
require 'facebook/messenger'

RSpec.describe Listener, type: :request do
  FakeMessage = Struct.new(:sender, :recipient, :timestamp, :message)

  describe 'Bot#on(message)' do
    it 'responds with a message' do
      expect(Bot).to receive(:deliver)
      Bot.trigger(:message, fake_message)
    end
  end

  private

  def fake_message
    sender = {"id"=>"1234"}
    recipient = {"id"=>"5678"}
    timestamp = 1528049653543
    message = {"text"=>"Hello, world"}
    FakeMessage.new(sender, recipient, timestamp, message)
  end
end
