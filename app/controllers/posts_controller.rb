class PostsController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash_now_store(@post)
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash_now_store(@post)
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).delete
    redirect_to '/'
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
