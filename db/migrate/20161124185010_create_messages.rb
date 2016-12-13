class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :emergency, foreign_key: true
      t.text :text
      t.boolean :claim_closed

      t.timestamps
    end
  end
end
