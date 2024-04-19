class RenameGenresToBookGenres < ActiveRecord::Migration[7.1]
  def change
    rename_table :genres, :book_genres
  end
end
