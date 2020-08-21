Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   post 'auth/login', to: 'authentication#authenticate'
   post 'auth/signup', to: 'user#create'
   post 'auth/verify_email', to: 'user#verify_email'
   patch 'user', to:'user#update'
   get 'user', to: 'user#show'
   delete 'user', to: 'user#delete'

   get 'market/items', to: 'item#index'
   post 'market/items', to: 'item#create'
   get 'user/items', to: 'item#show_user_items'
   patch 'market/items/:id', to: 'item#update'

   get 'market/items/rating/:id', to: 'item#get_item_ratings'
   post 'market/items/rating/:id', to: 'item#rate_item'

   get 'market/items/comment/:item_id', to: 'comment#index'
   post 'market/items/comment/:item_id', to: 'comment#create'

   get 'market/items/order', to: 'order#show_all_user_orders'
   post 'market/items/order', to: 'order#create'
   get 'market/items/order/:order_id', to: 'order#show'
end
