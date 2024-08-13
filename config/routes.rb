require 'sidekiq/web'

Rails.application.routes.draw do

  resources :picture_users do
    collection do
      post 'like'
      post 'dislike'
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :pictures do
    collection do
      get 'add_multiple'
      post 'create_multiple'
      get "results/:user_id", to: "pictures#results", as: :results
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pictures#index"

  mount Sidekiq::Web => "/sidekiq"
end
