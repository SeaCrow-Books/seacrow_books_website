class RenameGenreIdToBookGenreIdInBooks < ActiveRecord::Migration[7.1]
  def change
    rename_column :books, :genre_id, :book_genre_id
  end
end
