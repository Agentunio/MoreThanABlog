class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: %i[ edit update destroy ]
  before_action :require_roles_permission, only: %i[ new edit lista create update destroy ]
  
  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end


  def lista
    @roles = Role.all.order('name ASC')
  end
  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)

      if @role.save
        redirect_to admin_path, notice: "Nowa rola utworzona" 
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
      if @role.update(role_params)
        redirect_to admin_path, notice: "Rola zaktualizowana"
      else
        ender :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy!

    redirect_to lista_admin_roles_path, status: :see_other, notice: "Rola usunięta" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.expect(role: [ :name, :panelpriv, :postspriv, :rolespriv, :userspriv ])
    end


    def require_roles_permission
      require_permission(:rolespriv)
    end
end
