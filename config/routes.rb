Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'

  resource :session, only: [:create]
  resources :user, only: [:create] do
    delete 'destroy', on: :collection
  end
  resources :password, only: [] do
    post 'forgot_password', on: :collection
    post 'reset_password', on: :collection
  end

  # Defines the root path route ("/")
  # root "posts#index"
  match "*unmatched", to: "unhandled#index", via: :all
end
