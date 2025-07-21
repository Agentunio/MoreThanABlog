class PagesController < ApplicationController
  before_action :set_page, only: %i[ edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  # GET /pages/1 or /pages/1.json
  def show
    segments = params[:slug].to_s.split("/")

    @page = segments.reduce(nil) do |parent, slug|
      scope = parent ? parent.children : Page.roots 
      scope.friendly.find(slug)                  
    end

  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to site_page_path(@page.path.map(&:slug).join("/")), notice: "Strona została utworzona."
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    if @page.update(page_params)
      redirect_to @page, notice: "Strona została zaktualizowana."
    else
      render :edit
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy!

    redirect_to pages_url, notice: "Strona została usunięta."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params.expect(:slug))
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.expect(page: [ :title, :content, :parent_id ])
    end
end
