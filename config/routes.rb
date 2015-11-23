Rails.application.routes.draw do



devise_for :users 
 root 'shops#index'

get 'users/:user_id/orders' => 'users#index', as: :user_orders
get 'users/:user_id/orders/:id' => 'users#show_order', as: :user_order
get 'users/:user_id/orders/:id/edit' => 'users#edit_order', as: :edit_user_order
patch 'users/:user_id/orders/:id' => 'users#update_order', as: :update_user_order
delete 'users/:user_id/orders/:id/cancel' => 'users#cancel_order', as: :cancel_user_order
    
  resources :shops do
    get 'orders/fulfilled' => 'orders#fulfilled_orders', as: :orders_fulfilled
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


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
