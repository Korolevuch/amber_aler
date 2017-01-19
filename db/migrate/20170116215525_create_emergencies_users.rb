class CreateEmergenciesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :emergencies_users, id: false do |f|
      f.integer :user_id
      f.integer :emergency_id
    end
  end
end
