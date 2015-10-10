Rails.application.routes.draw do
 root to: 'pages#index'


 # Api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1 do
      # We are going to list our resources here
      post 'prettify', to: 'pretty_numbers#prettify'
      resources :pretty_numbers, only: [:index, :show, :create, :update, :prettify, :destroy]
    end
  end
 
 post 'prettify', to: 'pretty_numbers#prettify'

 resources :pretty_numbers

 devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


end
