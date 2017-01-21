class AddEditor
  attr_reader :emergency, :params

  def self.call(emergency, params)
    new(emergency, params).perform
  end

  def initialize(emergency, params)
    @emergency = emergency
    @params = params
  end

  def perform
    return incorrect_user unless editor&.active?
    return editor_already if present_in_list?
    add_user_to_editors
    successfully_added
  end

  def successfully_added
    { success: 'Editor was added' }
  end

  def incorrect_user
    { error: 'Incorrect user' }
  end

  def editor_already
    { error: 'User already in the list' }
  end

  private

  def add_user_to_editors
    emergency.users << editor
  end

  def present_in_list?
    emergency.users.exists?(editor)
  end

  def editor
    User.find_by(email: params[:q]) if params[:q].present?
  end
end
