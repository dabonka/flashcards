class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
   @user = User.new
  end

  def edit
    @user = User.find(params[:id])

  end

  def create
    @user = User.new(users_params)
    @user.save!
    redirect_to @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id)
  end

end