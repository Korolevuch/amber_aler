module Admin::AdminHelper
  def admin_policy
    AdminPolicy.new(current_user: current_user, user_signed_in: user_signed_in?)
  end
end
