module MessageHelper
  def message_policy(message)
    MessagePolicy.new(message: message, current_user: current_user)
  end
end
