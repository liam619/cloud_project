class CreateDislikeBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :dislike_books do |t|
      t.integer :book_id
      t.integer :dislike_count, default: 1

      t.timestamps
    end
  end
end
