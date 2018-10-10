class PagesController < ApplicationController
  def welcome
    @messages = FacebookMessage.all
    render json: @messages
  end
end
