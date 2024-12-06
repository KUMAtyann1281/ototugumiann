class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :content)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to new_admin_session_path
    end
  end
end
