class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :toggle_active]

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

  def toggle_active
    @user.toggle! :active
    redirect_to([:admin, :users])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def params_for_user
    params.require(:user).permit(:name, :email, :role, :active)
  end

end
