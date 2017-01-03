class AddStatusToEmergencies < ActiveRecord::Migration[5.0]
  def change
    add_column :emergencies, :status, :integer, default: 0
  end
end
