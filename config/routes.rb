require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  namespace :admin, path: "panel-admina" do

    get "/", to: "dashboard#index" 

    resources :pages, path: "strony", except: %i[ show ] do
      collection { get "lista", to: "pages#lista", as: :lista }
    end

    resources :posts, path: "wpisy", except: %i[index show] do
      delete "remove_image/:image_id", to: "posts#remove_image",
                                       as: :remove_image, on: :member
      collection do
        get  "lista", to: "posts#lista",  as: :lista  
      end
    end

    resources :roles, path: "role" do
      collection { get "lista", to: "roles#lista", as: :lista }
    end

    get   "uzytkownicy",        to: "user_panel#index",        as: :users
    patch "uzytkownicy/:id",        to: "user_panel#update_user",  as: :users_save
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  post '/upload-image-endpoint', to: 'uploads#image'
  resources :posts, path: "wpisy", only: %i[ index show ], as: "wpisy"

  get "kontakt", to: "contact#index"
  post "kontakt", to: "contact#create"


  root "posts#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "/*slug", to: "pages#show", as: :site_page, format: false,
    constraints: ->(req) {
      req.path != "/" && !req.path.match?(/\.[a-z0-9]{2,5}$/i)
    }
end
