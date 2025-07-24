module Admin
  class PagesController < BaseController
    before_action :set_page, only: %i[ edit update destroy ]
    before_action :authenticate_user!, only: %i[ new create lista edit update destroy ]
    before_action :require_pages_permission, only: %i[ new edit lista create update destroy ]

    def new
      @page = Page.new
    end

    def edit
    end

    def create
      @page = Page.new(page_params)

      if @page.save
        redirect_to site_page_path(@page.path.map(&:slug).join("/")), notice: "Strona została utworzona."
      else
        render :new
      end
    end

    def update
      if @page.update(page_params)
        redirect_to site_page_path(@page.path.map(&:slug).join("/")), notice: "Strona została zaktualizowana."
      else
        render :edit
      end
    end

    def destroy
      @page.destroy!

      redirect_to lista_admin_pages_path, notice: "Strona została usunięta."
    end

    def lista
      @pages = Page.select(:id, :title, :slug).order(:created_at)
    end

    private
      def set_page
        @page = Page.friendly.find(params[:id])
      end

      def page_params
        params.expect(page: [:title, :content, :parent_id, :in_nav])
      end

      def require_pages_permission
        require_permission(:pagespriv)
      end
  end
end