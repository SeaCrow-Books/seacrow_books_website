class AddGenreIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :genre_id, :integer
    add_index :books, :genre_id
  end
end
