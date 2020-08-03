Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   post 'auth/login', to: 'authentication#authenticate'
   post 'auth/signup', to: 'user#create'
   patch 'user/:id', to:'user#update'
   get 'user/:id', to: 'user#show'
   delete 'user/:id', to: 'user#delete'
   get 'user/:user_id/items', to: 'user#show_items'

   get 'market/items', to: 'item#index'
   post 'market/items', to: 'item#create'
   put 'market/items', to: 'items#update'
end
