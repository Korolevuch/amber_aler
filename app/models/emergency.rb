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

  ACTIVE   = 0
  CLOSED   = 1
  ARCHIVED = 2

  enum status: { active: ACTIVE, closed: CLOSED, archived: ARCHIVED }

  scope :not_archived,      -> { where.not(status: ARCHIVED) }
  scope :not_archived_desc, -> { not_archived.order(updated_at: :desc) }

  def allow_messages_for?(current_user)
    active? || current_user == user
  end
end
