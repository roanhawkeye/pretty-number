Rails.application.routes.draw do
 root to: 'pages#index'

 post 'prettify', to: 'pretty_numbers#prettify'

 resources :pretty_numbers

 devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

end
