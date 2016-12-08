class AddStatusToEmergencies < ActiveRecord::Migration[5.0]
  def change
    add_column :emergencies, :status, :string, default: 'active'
  end
end
