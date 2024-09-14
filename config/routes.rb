Rails.application.routes.draw do
  resources :auth_services
  post 'auth/login'
  post 'auth/register'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }

  namespace :api do
    resources :youtubes, only: [:index, :create]
  end

  mount ActionCable.server => '/cable'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
