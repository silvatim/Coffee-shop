Rails.application.routes.draw do

devise_for :users

root 'pages#home'
get '/pages/:page' => 'pages#show'
get '/about' => 'pages#about'
get '/contact' => 'pages#contact'

get 'users/:user_id/orders' => 'users#index', as: :user_orders
get 'users/:user_id/orders/:id' => 'users#show', as: :user_order
get 'users/:user_id/orders/:id/edit' => 'users#edit', as: :edit_user_order
patch 'users/:user_id/orders/:id' => 'users#update', as: :update_user_order
delete 'users/:user_id/orders/:id' => 'users#destroy'


 resources :shops do
   get 'orders/fullfilled' => 'orders#fulfilled_orders', as: :orders_completed
     resources :orders do
        put 'completed'
        put 'estimated'
        put 'paid'
        put 'cancel'
        put 'forgotten'
        put 'reject'
        put 'accept'
      end
   end
end
