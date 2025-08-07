module Api
  class CurrentUserController < ApplicationController
    before_action :authenticate_user!

    def index
      if current_user
        render json: {
          username: current_user.username,
          email: current_user.email
        }, status: :ok
      else
        render json: { error: 'Nie znaleziono użytkownika' }, status: :not_found
      end
    end
  end
end
