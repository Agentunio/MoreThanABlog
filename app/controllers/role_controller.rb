class RoleController < ApplicationController
  def index
  end
  def new
    @roles = Role.all
  end
  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to panel_admina_path, notice: "Role dodano poprawnie"
    else
      render :index, alert: "Nie udało się poprawnie"
    end
  end
  def delete
    if @role.destroy!
      redirect_to panel_admina_path, notice: "Rola usunięta poprawnie"
    else
      render :index, alert: "Nie udało się poprawnie"
    end
  end



  private

  def role_params
    params.permit(:name)
  end
end
