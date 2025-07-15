Rails.application.routes.draw do
  resources :roles , path: "panel-admina/role"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :posts, path: "panel-admina/wpisy", expect: %i[ index show ]
  resources :posts, path: "wpisy", only: %i[ index show ], as: "wpisy"

  get "panel-admina", to: "admin#index"
  get "panel-admina/lista-wpisy", to: "posts#lista", as: "panel_admina_lista_wpisy"
  get "panel-admina/lista-role", to: "roles#lista", as: "panel_admina_lista_role"

  get "panel-admina/uzytkownicy", to: "user_panel#index", as: :panel_admina_users
  patch "panel-admina/uzytkownicy", to: "user_panel#update_user", as: :panel_admina_users_save

  post '/upload-image-endpoint', to: 'uploads#image'


  get "kontakt", to: "contact#index"

  root "posts#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
