module Api
class Api::PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]
  
  def index
    posts  = Post.with_attached_main_image.includes(:user).order(Arel.sql("COALESCE(custom_date, updated_at) DESC"))

    render json: PostSerializer.new(posts).serializable_hash
  end

  def show
  end

  private
    
    def set_post
      @post = Post.find(params.expect(:id))
    end

end
end
