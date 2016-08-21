class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_back_or_to(:root, notice: t("user.in"))
    else
      flash.now[:alert] = I18n.t("user.error")
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: I18n.t("user.out"))
  end
end