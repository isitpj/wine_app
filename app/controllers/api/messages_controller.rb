class Api::MessagesController < ApplicationController
  def index
    @messages = FacebookMessage.all
    render json: @messages
  end

  def create
    FacebookMessage.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:name, :category, :body)
  end
end
