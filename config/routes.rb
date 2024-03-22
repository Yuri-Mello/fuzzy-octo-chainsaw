Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :movies, only: [:index, :new, :create] do
    post 'bulk_create', on: :collection
  end
  resources :user_movies, only: [:create, :update] do
    post 'bulk_create', on: :collection
  end
 
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  scope '/api' do
    resources :external_movies, only: [:index, :new, :create] do
      post 'bulk_create', on: :collection
    end
    resources :external_sessions, only: [:create]
    
    post '/login', to: 'external_sessions#create'
  end

  root 'sessions#new'
end
