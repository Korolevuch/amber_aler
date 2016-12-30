class TopEmergencies

  def self.call
    new.top_three
  end

  def top_three
     top = Hash.new
     last_two_days_emergencies.inject(0) do |c, em|
      c = em.messages.count
      top[em] = c
    end
    top.sort_by(&:last).last(3).to_h
  end

  private
  def last_two_days_emergencies
    @last_two_days_emergencies ||= Emergency.where(created_at: last_two_days)
  end

  def last_two_days
    (Time.now - 2.day)..Time.now
  end
end
