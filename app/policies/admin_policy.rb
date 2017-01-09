class AdminPolicy
  attr_reader :current_user

  def initialize(params = {})
    @current_user = params[:current_user]
  end

  def user_admin?
    current_user&.admin?
  end
end
