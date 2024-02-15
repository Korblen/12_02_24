Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get 'team', to: 'static_pages#team'
  get 'contact', to: 'static_pages#contact'
  root 'static_pages#home'
  get 'welcome/:first_name', to: 'static_pages#welcome'
  get 'home', to: 'static_pages#home'
  resources :gossips, only: [:new, :create]
  get 'gossips/:id', to: 'gossips#show', as: 'gossip'
  resources :users, only: [:new, :create]
  get 'users/:id', to: 'users#show', as: 'user'
  resources :cities, only: [:show]
  resources :gossips, only: [:edit, :update]
  resources :gossips do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  resources :users, only: [:edit, :update]
end
