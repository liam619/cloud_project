class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :author_id
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
