Rails.application.routes.draw do
  devise_for :users
 root to: 'pages#index'

 post 'prettify', to: 'pretty_numbers#prettify'

 resources :pretty_numbers

end
