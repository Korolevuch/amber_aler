class EmergencyQuery

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
    last_two_days_emergencies.sort {|a,b| a.messages.size <=> b.messages.size}.last(3)
  end

  private

  def last_two_days_emergencies
    @last_two_days_emergencies ||= Emergency.where(created_at: last_two_days)
  end

  def last_two_days
    (Time.now - 2.day)..Time.now
  end
end
