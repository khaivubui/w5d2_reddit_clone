class SubsController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = current_user.subs.new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash_now_store(@sub)
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash_now_store(@sub)
      render :edit
    end
  end

  def destroy
    Sub.find(params[:id]).delete
    redirect_to '/'
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
