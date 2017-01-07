class ProfilePolicy
  attr_reader :profile, :current_user

  def initialize(params)
    @profile = params[:profie]
    @current_user = params[:currnet_user]
  end

  def profile?
    profile == current_user
  end
end
