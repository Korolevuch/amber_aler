module UserHelper

  def user_policy
    @user ||= UserPolicy.new(current_user: current_user)
  end
end
