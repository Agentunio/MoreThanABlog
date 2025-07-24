module Admin
  class UserPanelController < BaseController
    before_action :authenticate_user!
    before_action :require_users_permission, only: %i[ index update_user ]

    def index
      admin_role_id = Role.find_by(name: "Admin").id
      @users = User.select(:username, :email, :id, :role_id).where("role_id != #{admin_role_id} AND id != #{current_user.id}").order('email ASC')
      if current_user.role.name == "Admin"
        @roles = Role.select(:name, :id)
      else
        @roles = Role.select(:name, :id).where("name != 'Admin'")
      end
    end

    def update_user
      if params[:user][:role_name].present?
        user = User.find_by(id: params[:id])
        role = Role.find_by(name: params[:user][:role_name])

        if user.update(role_id: role.id)
          redirect_to admin_users_path, notice: "Rola zaktualizowana"
        else
          redirect_to admin_users_path, alert: "Rola niezostala zaktualizowana pomyslnie"
        end
      else
        redirect_to admin_users_path, alert: "Wybierz role"
      end
    end

    private

      def require_users_permission
        require_permission(:userspriv)
      end
  end
end