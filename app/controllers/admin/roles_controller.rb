module Admin
  class RolesController < BaseController
    before_action :authenticate_user!
    before_action :set_role, only: %i[ edit update destroy ]
    before_action :require_roles_permission, only: %i[ new edit lista create update destroy ]
    
    def new
      @role = Role.new
    end

    def edit
    end


    def lista
      @roles = Role.select(:name, :id).order("name ASC")
    end

    def create
      @role = Role.new(role_params)

        if @role.save
          redirect_to admin_path, notice: "Nowa rola utworzona"
        else
          render :new, status: :unprocessable_entity
        end
    end

    def update
        if @role.update(role_params)
          redirect_to admin_path, notice: "Rola zaktualizowana"
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
      @role.destroy!

      redirect_to lista_admin_roles_path, status: :see_other, notice: "Rola usunięta"
    end

    private
      def set_role
        @role = Role.find(params.expect(:id))
      end

      def role_params
        params.expect(role: [:name,:panelpriv,:postspriv,:rolespriv,:userspriv,:pagespriv])
      end


      def require_roles_permission
        require_permission(:rolespriv)
      end
  end
end