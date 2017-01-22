class MessagePolicy
  attr_reader :message, :current_user

  def initialize(params = {})
    @message = params[:message]
    @current_user = params[:current_user]
  end

  def user_can_close_emergency?
    message.emergency.user == current_user
  end

end
