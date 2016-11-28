Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :emergencies
  resources :messages, only: [ :create, :new, :edit, :update, :destroy ]
end
