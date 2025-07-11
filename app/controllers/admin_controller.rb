class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action { require_permission(:postspriv) }, only: [:index]
  before_action { require_permission(:postspriv, strict: true) }
  def index
  end
  def lista
    if params[:type] == "roles"
      @roles = Role.all.order('name ASC')
    else
      @posts = Post.all
    end
  end
  def users
    @users = User.all.order('email ASC')
    @roles = Role.all
  end
  def update
    user = User.find_by(id: params[:format])
    role = Role.find_by(name: params[:user][:role_name])
    puts role
    if user.update(role_id: role.id)
      redirect_to panel_admina_users_path, notice: "Rola zaktualizowana"
    else
      redirect_to panel_admina_users_path, alert: "Rola niezostala zaktualizowana pomyslnie"
    end
  end
end
