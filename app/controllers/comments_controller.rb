class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      render :post_comments
    else
      render 'posts/show'
    end
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

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
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_update_params
    params.require(:comment).permit(:comment)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
