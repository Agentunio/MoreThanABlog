module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!

    private

    def require_permission(privilege, strict: false)
      unless current_user&.role&.send(privilege)
        if strict
          head :forbidden
        else
          redirect_to root_path, alert: "Brak dostępu."
        end
      end
    end
    
  end
end