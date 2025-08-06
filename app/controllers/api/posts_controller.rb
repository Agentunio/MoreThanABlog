module Api
  class PostsController < ApplicationController
    before_action :set_post, only: %i[ show ]
    
    def index
      posts  = Post.with_attached_main_image.includes(:user).order(Arel.sql("COALESCE(custom_date, updated_at) DESC"))

      render json: PostsSerializer.new(posts).serializable_hash
    end

    def show
      render json: PostSerializer.new(@post).serializable_hash
    end

    private
      
      def set_post
        @post = Post.friendly.find(params[:id])
      end

  end
end
