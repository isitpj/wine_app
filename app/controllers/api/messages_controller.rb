class Api::MessagesController < ApplicationController
  def index
    @messages = FacebookMessage.all
    render json: @messages
  end
end
