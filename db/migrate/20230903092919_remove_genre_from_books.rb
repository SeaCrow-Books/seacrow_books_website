class RemoveGenreFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :genre, :string
  end
end
