class Api::MessagesController < ApplicationController
  def index
    @messages = FacebookMessage.all
    render json: @messages
  end

  def create
    @message = FacebookMessage.create(message_params)
    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:name, :category, :body)
  end
end
