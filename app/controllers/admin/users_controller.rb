class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit; end

  def update
    if @user.update(params_for_user)
     redirect_to([:admin, :users])
    else
      render(:edit)
    end
  end

  def destroy
    @user.destroy!
    redirect_to([:admin, :user])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def params_for_user
    params.require(:user).permit(:name, :email, :role)
  end

end
