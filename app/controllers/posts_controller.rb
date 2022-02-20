class PostsController < ApplicationController
  before_action :correct_post,only: [:edit, :destroy]
  before_action :authenticate_user!, only: [:new]

  def index
    # @post_5 = Post.find_by(is_admin_deleted: false)
    @post_5 = Post.last(5)
    # @post_5 = @post.all
    @posts = Post.all.order(created_at: :desc)

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    # @comments = Comment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if current_admin
      post.update(is_admin_edited: true)
      post.update(post_params)
      redirect_to admin_post_path(post)
    elsif post.user_id == current_user.id
      post.update(is_admin_edited: true)
      post.update(post_params)
      redirect_to post_path(post)
    else
      post.update(post_params)
      redirect_to post_path(post)
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.update(is_admin_deleted: true)
    redirect_to "/"
    # @post = Post.find(params[:id])
    # @post.destroy
    # redirect_to "/"
  end

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to "/"
    end
  end

  private

    def post_params
      params.require(:post).permit(:main_title, :date, :location, :sub_title, :body, { images: [] })
    end
end
