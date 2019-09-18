class CreateCategoriesBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_books do |t|
      t.integer :category_id
      t.integer :book_id
    end
  end
end
