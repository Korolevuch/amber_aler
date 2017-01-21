class AddEditor
  attr_reader :emergency, :params

  def self.call(emergency, params)
    new(emergency, params).perfome
  end

  def initialize(emergency, params)
    @emergency = emergency
    @params = params
  end

  def perfome
    result = emergency.users << editor if !emergency.users.exists?(editor) && (editor != nil && editor.active?)
    result != nil ? { success: 'Editor aded' } : { error: 'Incorect user or user already in the list' }
  end

  private

  def editor
    User.find_by(email: params[:q]) if params[:q].present?
  end
end
