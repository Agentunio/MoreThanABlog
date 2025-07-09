class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def lista
    @posts = Post.all
  end
end
