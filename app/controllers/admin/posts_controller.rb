module Admin
  class PostsController < BaseController
    before_action :set_post, only: %i[ edit update destroy ]
    before_action :set_users, only: %i[ edit update ]
    before_action :authenticate_user!, only: %i[ new edit create update destroy lista remove_image ]
    before_action :require_posts_permission, only: %i[ new edit lista create update destroy remove_image ]

    def new
      @post = Post.new
    end

    def edit
      @author_of_post = @post.user.username
    end

    def lista
        @posts = Post.select(:id, :title, :slug).order(Arel.sql("COALESCE(custom_date, updated_at) DESC"))
    end

    def create
      @post = current_user.posts.build(post_params)

      if @post.save
          redirect_to wpisy_path(@post), notice: "Wpis stworzony pomyślnie."
      else
          render :new, status: :unprocessable_entity
      end
    end

    def update
        if @post.update(post_params.except(:gallery))
          if post_params[:gallery]
            post_params[:gallery].each do |new_image|
              @post.gallery.attach(new_image)
            end
          end

          redirect_to wpisy_path(@post), notice: "Wpis zaktualizowany pomyślnie."
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def remove_image
      @post = Post.find(params[:id])
      image = @post.gallery_attachments.find(params[:image_id])

      if image.purge
        redirect_to edit_admin_post_path(@post), notice: "Zdjęcie zostało usunięte."
      else
      render :edit, status: :unprocessable_entity, alert: "Nie znaleziono zdjęcia."
      end
    end


    def destroy
      @post.destroy!

      redirect_to lista_admin_posts_path, status: :see_other, notice: "Wpis usunięty pomyślnie."
    end

    private

      def set_users
        @users = User.select(:id, :username).where("role_id != 7")
      end

      def set_post
        @post = Post.find(params.expect(:id))
      end

      def post_params
        params.expect(post: [:title,:content,:main_image,:custom_date,:user_id,gallery: []])
      end

      def require_posts_permission
        require_permission(:postspriv)
      end
  end
end