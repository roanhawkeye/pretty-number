Rails.application.routes.draw do
 root to: 'pages#index'

 post 'prettify', to: 'pretty_numbers#prettify'

 resources :pretty_numbers

end
