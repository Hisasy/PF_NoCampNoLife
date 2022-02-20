class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @post_5 = Post.last(5)
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    # @admin = admin.is_admin_edited
  end

  def edit
    @post = Post.find(params[:id])
  end

  # def update
  #   post = Post.find(params[:id])
  #   if current_admin
  #     post.main_title = post.main_title + "(edited)"
  #     post.update(post_params)
  #   else
  #     post.update(post_params)
  #   end
  #   redirect_to admin_post_path
  # end

  def destroy
    @post = Post.find(params[:id])
    @post.update(is_admin_deleted: true)
    redirect_to "/admin/posts"
  end

  private

    def post_params
      params.require(:post).permit(:main_title, :date, :location, :sub_title, :body, { images: [] })
    end
end
