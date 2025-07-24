module Admin
  class DashboardController < BaseController
    before_action :authenticate_user!
    before_action :require_panel_permission

    def index
    end

    private

      def require_panel_permission
        require_permission(:panelpriv)
      end
  end
end