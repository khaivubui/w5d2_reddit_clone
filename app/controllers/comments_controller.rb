class CommentsController < ApplicationController
  before_action :ensure_logged_in, except: :show

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
    unless @comment.save
      flash_store(@comment)
    end
    redirect_to request.referrer
  end

  def destroy
    @comment = Comment.find(params[:id]).delete
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
