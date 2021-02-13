class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :visiter, foreign_key: { to_table: :users }, null: false
      t.references :visited, foreign_key: { to_table: :users }, null: false
      t.references :photo, foreign_key: true
      t.references :comment, foreign_key: true
      t.string :action, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end