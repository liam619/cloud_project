class CreateLikeBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :like_books do |t|
      t.integer :book_id
      t.integer :like_count, default: 1

      t.timestamps
    end
  end
end
