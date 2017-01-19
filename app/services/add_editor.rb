class AddEditor
  attr_reader :emergency, :params

  def self.call(emergency, params)
    new(emergency, params).add_editor_to_emergecy
  end

  def initialize(emergency, params)
    @emergency = emergency
    @params = params
  end

  def add_editor_to_emergecy
    emergency.users << editor if !emergency.users.include?(editor)
  end

  private

  def editor
    User.find_by(email: params[:q]) if params[:q].present?
  end
end
