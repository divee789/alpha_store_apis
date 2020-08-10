Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   post 'auth/login', to: 'authentication#authenticate'
   post 'auth/signup', to: 'user#create'
   patch 'user', to:'user#update'
   get 'user', to: 'user#show'
   delete 'user', to: 'user#delete'
   get 'user/items', to: 'user#show_items'

   get 'market/items', to: 'item#index'
   post 'market/items', to: 'item#create'
   patch 'market/items/:id', to: 'item#update'

   get 'market/items/comment/:item_id', to: 'comment#index'
   post 'market/items/comment/:item_id', to: 'comment#create'
end
