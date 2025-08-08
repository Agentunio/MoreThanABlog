module Api
  module Admin
    class PostsController < ApplicationController
      before_action :authenticate_user!
      before_action :require_posts_permission
      before_action :set_post, only: %i[update destroy]
      skip_before_action :verify_authenticity_token
      
      def create
        post = current_user.posts.build(post_params.except(:gallery))

        if post.save
          attach_gallery(post)          #  ← dołączamy po zapisie
          render json: { id: post.id, slug: post.slug }, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params.except(:gallery))
          if post_params[:gallery].present?
            post_params[:gallery].each { |img| @post.gallery.attach(img) }
          end
          head :no_content
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy!
        head :no_content
      end

      private

      def attach_gallery(post)
        return unless post_params[:gallery].present?

        post_params[:gallery].each { |img| post.gallery.attach(img) }
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(
          :title, :content, :main_image, :custom_date, :user_id, gallery: []
        )
      end

      def require_posts_permission
        require_permission(:postspriv)
      end
    end
  end
end
