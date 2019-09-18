class CreateBooksDistributors < ActiveRecord::Migration[5.2]
  def change
    create_table :books_distributors do |t|
      t.integer :book_id
      t.integer :distributor_id
    end
  end
end
