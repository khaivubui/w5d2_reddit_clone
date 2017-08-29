class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to '/'
    else
      flash_now_store(@user)
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @subs = @user.subs
    @posts = @user.posts
  end
end
