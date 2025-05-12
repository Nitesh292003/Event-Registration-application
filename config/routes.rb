# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users do
    collection do
      post :sign_in, to: 'sessions#create'
    end
  end

  post 'payments/success', to: 'payments#payment_success_url'
  post 'payments/failure', to: 'payments#payment_failure_url'

  get 'discount_codes/user/:user_id', to: 'discount_codes#discount_codes_by_user'

  resources :roles
  get '/events/user/:user_id', to: 'events#index_by_user'

  resources :events
  resources :event_types
  resources :venues, only: %i[index show create update destroy]
  get 'discount_codes/event/:event_id', to: 'discount_codes#discount_codes_by_event'

  resources :discount_codes
  resources :event_registrations
  resources :event_bookings
  resource :price_calculator, only: [] do
    # Route to calculate total price
    post :total_price, on: :collection
    # Route to apply early bird discount
    post :early_bird_discount, on: :collection
    # Route to apply a discount code
    post :apply_discount, on: :collection
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
