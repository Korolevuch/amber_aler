class AdminPolicy
  attr_reader :current_user, :user_signed_in

  def initialize(params = {})
    @current_user = params[:current_user]
    @user_signed_in = params[:user_signed_in]
  end

  def user_admin?
    user_signed_in && current_user.admin?
  end

end
