class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!


  def edit
    @post = Post.find(params[:post_id])
    @comments = @post.comments

  end

  def update
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    if current_admin
      @comments.update(is_admin_edited: true)
      @comments.udpate
    else
      @comments.update
    end

    @comments.update
    redirect_to admin_post_path(@post)

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
end
