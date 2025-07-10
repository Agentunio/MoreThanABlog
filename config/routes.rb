Rails.application.routes.draw do
  devise_for :users
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "panel-admina", to: "admin#index"
  get "panel-admina/lista-wpisow", to: "admin#lista"
  get "panel-admina/role/zmiana-roli", to: "role#index"
  post "panel-admina/role/zmiana-roli", to: "role#create"
  get "panel-admina/role/edycja-roli", to: "role#new"
  get "panel-admina/role/edycja-roli/:id", to: "role#edit"
  get "panel-admina/role/edycja-roli", to: "role#delete"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
