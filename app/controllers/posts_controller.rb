class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]
  
  def index
    posts_on_page = 12
    total_posts   = Post.count

    @how_many_page = [(total_posts.to_f / posts_on_page).ceil, 1].max

    page = params[:page].to_i
    page = 1 if page < 1

    if page > @how_many_page
      redirect_to root_path, alert: "Strona niedostępna." and return
    end

    offset  = (page - 1) * posts_on_page
    @posts  = Post.order(Arel.sql("COALESCE(custom_date, updated_at) DESC")).limit(posts_on_page).offset(offset)
  end

  def show
  end

  private
    
    def set_post
      @post = Post.find(params.expect(:id))
    end

end
