Rails.application.routes.draw do
  get 'pages/welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Facebook::Messenger::Server, at: 'bot'
  scope "/api", defaults: {format: :json} do
    get '/messages' => 'pages#welcome'
  end
end
