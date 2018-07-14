# frozen_string_literal: true

# :nodoc:
Rails.application.routes.draw do
  scope '/api' do
    # post '/users/token' => 'user_token#create'
    post '/users/token', to: 'user_token#dv_create'
    resources :users

    resources :lists
    resources :notes
    resources :tags

    get     '/tasks',     to: 'todotask_items#index'
    post    '/tasks',     to: 'todotask_items#create'
    get     '/tasks/:id', to: 'todotask_items#show'
    patch   '/tasks/:id', to: 'todotask_items#update'
    put     '/tasks/:id', to: 'todotask_items#update'
    delete  '/tasks/:id', to: 'todotask_items#destroy'

    get '/session/csrf' => 'application#csrf'
    get '/current' => 'users#current'
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
