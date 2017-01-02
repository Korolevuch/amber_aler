class EmergencyQueries

  attr_reader :params

  def self.call(params)
    new(params)
  end

  def initialize(params)
    @params = params
  end

  def emergencies
    emergencies = Emergency.not_archived.order(updated_at: :desc)
    emergencies = emergencies.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
    emergencies.page(params[:page]).per(5)
  end

  def top_emergencies
    TopEmergencies.call
  end
end
