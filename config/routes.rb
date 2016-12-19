Rails.application.routes.draw do
  root to: 'emergencies#index'
  devise_for :users
  resources :users
  resources :emergencies do
    resources :messages, except: [:index, :show, :new], shallow: true
  end
  namespace :admin do
    resources :users
  end
end
