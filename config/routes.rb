Rails.application.routes.draw do
  devise_for :users
  # root 'messages#index'
  # resources :users, only: [:index, :edit, :update]
  # resources :groups, only: [:new, :create, :edit, :update]

  root 'groups#index'
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :posts, only: [:index, :create]
    namespace :api do
      resources :posts, only: :index, defaults: { format: 'json' }
    end
  end
end
