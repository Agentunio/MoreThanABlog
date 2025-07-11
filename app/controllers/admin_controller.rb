class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def lista
    if params[:type] == "roles"
      @roles = Role.all
    else
      @posts = Post.all
    end
  end
  def users
    @users = User.all
    @roles = Role.all
  end
  def create

  end
end
