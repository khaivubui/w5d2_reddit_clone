class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = Comment.new(content: params[:comment][:content])
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
    unless @comment.save
      flash_store(@comment)
    end
    redirect_to post_url(@comment.post)
  end

  def destroy
    @comment = Comment.find(params[:id]).delete
    redirect_to post_url(@comment.post)
  end
end
