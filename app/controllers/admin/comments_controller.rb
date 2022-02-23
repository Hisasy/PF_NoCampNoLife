class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_comment, only: %i[update]


  def edit
    @post = Post.find(params[:post_id])
    @comments = @post.comments

  end

  def update
    @comment.update!(comment_update_params)
    render json: @comment
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).update(is_deleted: true)
    @post = Post.find(params[:post_id])
    render :post_comments
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def comment_update_params
    params.require(:comment).permit(:comment)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
