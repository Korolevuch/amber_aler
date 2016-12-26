class AddColumnLastActivityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_activity, :datetime
    add_column :users, :online, :boolean, default: false
  end
end
