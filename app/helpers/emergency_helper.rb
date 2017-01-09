module EmergencyHelper
  def emergency_policy(emergency)
    EmergencyPolicy.new(emergency: emergency, current_user: current_user)
  end
end

