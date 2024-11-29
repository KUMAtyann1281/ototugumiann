class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "本の感想を投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash.discard[:notice] = "タイトルまたは感想が空欄になっていますので入力をしてください。"
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿を修正しました。"
    else
      flash.discard[:notice] = "タイトルまたは感想が空欄になっていますので入力をしてください。"
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.user.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :content)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def ensure_correct_user
    if user_signed_in?
      @post = Post.find(params[:id])
      @user = @post.user
      unless @user.id == current_user.id
        redirect_to posts_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
