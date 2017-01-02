class TopEmergencies

  def self.call
    new.top_three
  end

  def top_three
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
