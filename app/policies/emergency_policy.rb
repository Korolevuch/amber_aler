class EmergencyPolicy
  attr_reader :emergency, :current_user

  def initialize(params = {})
    @emergency    = params[:emergency]
    @current_user = params[:current_user]
  end

  def my_emergency?
     emergency.users.include?(current_user) || emergency.user == current_user && current_user.active
  end

  def emergency_was_changing?
    emergency.updated_at != emergency.created_at
  end
end
