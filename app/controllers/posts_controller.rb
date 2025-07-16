class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_users, only: %i[ edit update ]
  before_action :authenticate_user!, only: %i[ new edit create update destroy ]
  before_action :require_posts_permission, only: %i[ new edit lista create update destroy ]
  # GET /posts or /posts.json
  def index
    page = params[:page].presence&.to_i || 1
    posts_on_page = 12
    offset = (page - 1) * posts_on_page
    @how_many_page = (Post.all.size.to_i / 12.to_f).ceil
    if page > @how_many_page || page < 1
      redirect_to root_path, alert: "Strona niedostępna."
    end
    @posts = Post.limit(posts_on_page).offset(offset).order(Arel.sql("COALESCE(custom_date, updated_at) DESC"))
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @author_of_post = @post.user.username
  end

  def lista
      @posts = Post.all.order(Arel.sql("COALESCE(custom_date, updated_at) DESC"))
  end
  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
        redirect_to @post, notice: "Wpis stworzony pomyślnie."
    else
        render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Wpis zaktualizowany pomyślnie." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to panel_admina_lista_wpisy_path, status: :see_other, notice: "Wpis usunięty pomyślnie." }
      format.json { head :no_content }
    end
  end

  private

    def set_users
      @users = User.select(:id, :username).where("role_id != 7")
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :content, :main_image, :custom_date, :user_id ])
    end

    def require_posts_permission
      require_permission(:postspriv)
    end
end
