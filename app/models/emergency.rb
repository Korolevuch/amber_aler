# == Schema Information
#
# Table name: emergencies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default("active")
#

class Emergency < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  enum status: {active: 0, closed: 1, archived: 2}

  scope :not_archived, -> { where.not(status: 'archived')}

  def allow_messages_for?(user)
    self.active? || user == self.user
  end

end
