class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :caption, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
