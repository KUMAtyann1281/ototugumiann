class Admin::NoticesController < ApplicationController
  before_action :authenticate_user!

  def new
    @notice = Notice.new
  end

  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.admin_id = current_admin.id
    if @notice.save
      flash[:notice] = "お知らせを投稿しました。"
      redirect_to admin_notices_path
    else
      flash.discard[:notice] = "タイトルまたは本文が空欄になっていますので入力をしてください。"
      render :new
    end
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update(notice_params)
      redirect_to admin_notice_path(@notice.id), notice: "お知らせを修正しました。"
    else
      flash.discard[:notice] = "タイトルまたは感想が空欄になっていますので入力をしてください。"
      render "edit"
    end
  end

  def destroy
    notice = Notice.find(params[:id])
    notice.destroy
    redirect_to admin_notices_path
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :body)
  end

  def authenticate_user!
    unless admin_signed_in?
      redirect_to new_admin_session_path
    end
  end

end
