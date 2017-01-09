class UserPolicy
  attr_reader :current_user

  def initialize(params = {})
    @current_user = params[:current_user]
  end

  def block?
    current_user && !current_user.active?
  end

  def messages_allow?(emergency)
    emergency.allow_messages_for?(current_user) && current_user&.active
  end

  def can_edit_message?(user)
   user == current_user && current_user.active
  end

  def autor_emerg_can_del_mess(user, emergency)
    emergency.user == current_user
  end
end
