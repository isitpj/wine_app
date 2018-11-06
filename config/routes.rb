Rails.application.routes.draw do
  get 'pages/welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Facebook::Messenger::Server, at: 'bot'
  namespace :api, defaults: {format: :json} do
    resources :messages, only: [:index, :create]
  end
end
