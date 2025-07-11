class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: %i[ edit update destroy ]

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to panel_admina_path, notice: "Nowa rola utworzona" }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: "Rola zaktualizowana" }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy!

    respond_to do |format|
      format.html { redirect_to panel_admina_path, status: :see_other, notice: "Rola usunięta" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.expect(role: [ :name ])
    end
end
