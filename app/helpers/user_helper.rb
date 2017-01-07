module UserHelper

  def user_policy
    UserPolicy.new(current_user: current_user)
  end

end
