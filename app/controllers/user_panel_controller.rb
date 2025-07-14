class UserPanelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_users_permission, only: %i[ index update_user ]

   def index
    @users = User.where("role_id != 4 AND id != #{current_user.id}").order('email ASC')
    @roles = Role.all
  end

  def update_user
    user = User.find_by(id: params[:format])
    role = Role.find_by(name: params[:user][:role_name])

    if user.update(role_id: role.id)
      redirect_to panel_admina_users_path, notice: "Rola zaktualizowana"
    else
      redirect_to panel_admina_users_path, alert: "Rola niezostala zaktualizowana pomyslnie"
    end
  end

  private

    def require_users_permission
      require_permission(:userspriv)
    end
end
