# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  emergency_id :integer
#  text         :text
#  claim_closed :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_messages_on_emergency_id  (emergency_id)
#  index_messages_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_273a25a7a6  (user_id => users.id)
#  fk_rails_51ec75cd65  (emergency_id => emergencies.id)
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :emergency, touch: true
  before_save :closed_emergency

  private

  def closed_emergency
    emergency.update(status: Emergency::CLOSED) if claim_closed?
  end
end
