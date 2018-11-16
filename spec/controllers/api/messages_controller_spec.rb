require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do

  describe 'GET - index' do
    it 'returns a success result' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns a JSON object' do
      create(:facebook_message, body: 'hello world')

      get :index

      parsed_response = JSON.parse(response.body)

      expect(parsed_response.length).to eq 1
    end
  end

  describe 'POST - create' do
    it 'creates a new message object' do
      expect { post :create, params: message_params}.to change { FacebookMessage.count }.from(0).to(1)
    end
  end

  private

  def message_params
     { message: { name: 'a name', category: 'fallback', body: 'hello, world'} }
  end
end
