class AddBookTropeIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :book_trope_id, :bigint
    add_index :books, :book_trope_id
  end
end
