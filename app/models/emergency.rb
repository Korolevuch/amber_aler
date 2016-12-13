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
#  status      :string           default("active")
#

class Emergency < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  STATUSES = [ACTIVE = :active, CLOSED = :closed, ARCHIVED = :archived]

  scope :active,   -> { where(status: ACTIVE) }
  scope :closed,   -> { where(status: CLOSED) }
  scope :archived, -> { where(status: ARCHIVED) }

  scope :not_archived, -> { where(status: STATUSES - [ARCHIVED]) }

  def allow_messages_for?(user)
    status == ACTIVE || user == self.user
  end
end
