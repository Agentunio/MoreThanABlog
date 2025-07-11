class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :require_permission

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
