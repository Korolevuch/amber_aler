class EmergencyPolicy
  attr_reader :emergency, :current_user

  def initialize(params = {})
    @emergency    = params[:emergency]
    @current_user = params[:current_user]
  end

  def emergency_was_changing?
    emergency.updated_at != emergency.created_at
  end

  def owner?
    emergency.user == current_user
  end

  def editor?
    emergency.users.include?(current_user)
  end

  def can_edit?
    editor? || owner? if user_active?
  end

  private

  def user_active?
    current_user&.active?
  end
end
