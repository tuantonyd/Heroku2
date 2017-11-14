Rails.application.routes.draw do
  resources :orders, :items, :contact_forms

  devise_for :users

  get 'welcome/index'
  get 'welcome/about'

  get '/cart', to: "items#cart", as: "cart"
  get '/checkout', to: "orders#new", as: "check_out"
  get '/cart/remove', to: "items#remove_cookie"
  get '/forbidden', to: 'welcome#forbidden', as: 'forbidden'

  get 'admin', to: "admin#index"
  get 'admin/items'
  get 'admin/reports'
  get '/admin/items/delete/:id', to: "items#destroy_item", as: "delete_item"
  get '/admin/users', to: 'admin#users', as: "user_management"
  get '/admin/toggleadmin/:id', to: 'admin#toggle_admin', as: "toggle_admin"

  get '/settings/editaccount', to: "users#edit", as: "edit_account"
  put '/settings/editaccount/:id', to: "users#update_account", as: "update_account"

  post '/add-to-cart', to: "application#create_cookie", as: 'add_to_cart'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  match '*path', to: redirect('/'), via: :all
end
